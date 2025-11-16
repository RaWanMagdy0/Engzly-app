import 'package:engzly/features/services/house_shifting/logic/booking_cubit.dart';
import 'package:engzly/features/services/house_shifting/logic/cubit.dart';
import 'package:engzly/features/services/house_shifting/logic/navigation_helper_booking_cubit.dart';
import 'package:engzly/features/services/house_shifting/logic/states.dart';
import 'package:engzly/features/services/house_shifting/ui/house_shifting_service/order_details/order_details.dart';
import 'package:engzly/features/services/house_shifting/ui/house_shifting_service/third_screen/widgets/location_bottom_sheet.dart';
import 'package:engzly/features/services/house_shifting/ui/house_shifting_service/third_screen/widgets/map_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:engzly/core/shared_widgets/custom_scaffold.dart';
import 'package:engzly/core/theming/images.dart';
import 'package:engzly/core/theming/colors.dart';
import 'widgets/address_top_bar.dart';

class HouseChooseLocationScreen extends StatefulWidget {
  const HouseChooseLocationScreen({super.key});

  @override
  State<HouseChooseLocationScreen> createState() =>
      _HouseChooseLocationScreenState();
}

class _HouseChooseLocationScreenState extends State<HouseChooseLocationScreen> {
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};
  LatLng? selectedLocation;
  double currentZoom = 16.0;
  String selectedAddress = "Cairo, Egypt";
  String selectedType = "home";

  @override
  void initState() {
    super.initState();
    context.read<HouseShiftingCubit>().getLocations();
    _initializeMap();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HouseShiftingCubit, HouseShiftingState>(
      listener: (context, state) {
        if (state is ConfirmLocationsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<HouseShiftingCubit>();
        final locations = cubit.locations;

        return CustomScaffoldScreen(
          title: const Text("Confirm Location"),
          leadingIcon: SvgPicture.asset(AppImages.backArrow,
              width: 30.w, height: 30.h, color: ColorsManager.black),
          notificationIcon: Image.asset(AppImages.notificationIcon,
              width: 28.w, height: 28.h, color: ColorsManager.black),
          onLeadingTap: () => Navigator.pop(context),
          child: Stack(
            children: [
              Positioned.fill(
                child: SimpleMapView(
                  mapController: _mapController,
                  selectedLocation: selectedLocation,
                  markers: _markers,
                  currentZoom: currentZoom,
                  onMapCreated: (c) => _mapController = c,
                  onMapTap: _handleMapTap,
                  onCameraMove: (pos) => currentZoom = pos.zoom,
                ),
              ),
              Positioned(
                top: 20.h,
                left: 16.w,
                right: 16.w,
                child: AddressTopBar(address: selectedAddress),
              ),
              if (state is ConfirmLocationsLoading)
                const Center(
                  child: CircularProgressIndicator(color: ColorsManager.orange),
                )
              else
                (locations.isNotEmpty
                    ? HouseShiftingLocationBottomSheet(
                        selectedAddress: selectedAddress,
                        selectedType: selectedType,
                        onTypeChanged: (type) {
                          setState(() => selectedType = type);
                        },
                        onSelectAddress: (address) {
                          setState(() => selectedAddress = address);
                        },
                        cubit: context.read<HouseShiftingBookingCubit>(),
                      )
                    : _buildEmptyLocationSheet(context)),
            ],
          ),
        );
      },
    );
  }

  Future<void> _initializeMap() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _setDefaultLocation();
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      selectedLocation = LatLng(position.latitude, position.longitude);
      String address = await _getDetailedAddress(selectedLocation!);
      _updateMarker(selectedLocation!, address);

      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(selectedLocation!, currentZoom),
      );
    } catch (e) {
      _setDefaultLocation();
    }
  }

  void _setDefaultLocation() {
    selectedLocation = const LatLng(30.0444, 31.2357);
    _updateMarker(selectedLocation!, "Cairo, Egypt");
  }

  Future<String> _getDetailedAddress(LatLng location) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(location.latitude, location.longitude);
      if (placemarks.isEmpty) return 'Unknown Location';
      Placemark place = placemarks.first;
      return "${place.street ?? ''}, ${place.locality ?? ''}, ${place.country ?? ''}";
    } catch (e) {
      return 'Location Error';
    }
  }

  void _handleMapTap(LatLng location) async {
    selectedLocation = location;
    String address = await _getDetailedAddress(location);
    _updateMarker(location, address);
  }

  void _updateMarker(LatLng location, String address) {
    setState(() {
      selectedAddress = address;
      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId('selectedLocation'),
          position: location,
          draggable: true,
          infoWindow: InfoWindow(title: address),
          onDragEnd: (newPosition) async {
            String newAddress = await _getDetailedAddress(newPosition);
            _updateMarker(newPosition, newAddress);
          },
        ),
      );
    });
  }

  Widget _buildEmptyLocationSheet(BuildContext context) {
    final bookingCubit = context.read<HouseShiftingBookingCubit>();

    return DraggableScrollableSheet(
      initialChildSize: 0.3,
      minChildSize: 0.25,
      maxChildSize: 0.4,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: ListView(
            controller: scrollController,
            children: [
              const Center(
                child: Text(
                  "No saved addresses",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  "Move the marker or tap on the map to choose a new location.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              24.verticalSpace,
              ElevatedButton(
                onPressed: () {
                  bookingCubit.selectLocation(selectedAddress);
                  navigateWithBookingCubit(context, const OrderDetails());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: const Text("Proceed"),
              ),
            ],
          ),
        );
      },
    );
  }
}
