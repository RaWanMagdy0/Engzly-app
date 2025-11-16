import 'package:engzly/features/services/vehicle/logic/vehicle_cubit.dart';
import 'package:engzly/features/services/vehicle/logic/vehicle_states.dart';
import 'package:engzly/features/services/vehicle/ui/vehicle/order_details/vehicle_order_details.dart';
import 'package:engzly/features/services/vehicle/ui/vehicle/third_screen/widgets/vehicle_location_bottom_sheet.dart';
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
import 'widgets/vehicle_address_top_bar.dart';

class VehicleChooseLocation extends StatefulWidget {
  const VehicleChooseLocation({super.key});

  @override
  State<VehicleChooseLocation> createState() => _VehicleChooseLocationState();
}

class _VehicleChooseLocationState extends State<VehicleChooseLocation> {
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};
  LatLng? selectedLocation;
  double currentZoom = 16.0;
  String selectedAddress = "Cairo, Egypt";
  String selectedType = "home";

  @override
  void initState() {
    super.initState();
    context.read<VehicleCubit>().getLocations();
    _initializeMap();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VehicleCubit, VehicleStates>(
      listener: (context, state) {
        if (state is VehicleLocationsError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final cubit = context.read<VehicleCubit>();
        final locations = cubit.locations;

        return CustomScaffoldScreen(
          title: const Text("Confirm Location"),
          leadingIcon: SvgPicture.asset(
            AppImages.backArrow,
            width: 30.w,
            height: 30.h,
            color: ColorsManager.black,
          ),
          notificationIcon: Image.asset(
            AppImages.notificationIcon,
            width: 28.w,
            height: 28.h,
            color: ColorsManager.black,
          ),
          onLeadingTap: () => Navigator.pop(context),
          child: Stack(
            children: [
              /// 🗺️ الماب دايمًا موجودة في الخلفية
              Positioned.fill(
                child: GoogleMap(
                  onMapCreated: (controller) => _mapController = controller,
                  initialCameraPosition: CameraPosition(
                    target: selectedLocation ?? const LatLng(30.0444, 31.2357),
                    zoom: currentZoom,
                  ),
                  markers: _markers,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  onTap: _handleMapTap,
                  onCameraMove: (pos) => currentZoom = pos.zoom,
                ),
              ),

              /// 📍 العنوان الحالي فوق
              Positioned(
                top: 20.h,
                left: 16.w,
                right: 16.w,
                child: VehicleAddressTopBar(address: selectedAddress),
              ),

              /// 🔄 الحالة: تحميل
              if (state is VehicleLocationsLoading)
                const Center(
                  child: CircularProgressIndicator(color: ColorsManager.orange),
                )
              else

                /// 📦 فيه عناوين؟ استخدم BottomSheet المناسب
                (locations.isNotEmpty
                    ? VehicleLocationBottomSheet(
                        selectedAddress: selectedAddress,
                        selectedType: selectedType,
                        onTypeChanged: (type) {
                          setState(() => selectedType = type);
                        },
                        onSelectAddress: (address) {
                          setState(() => selectedAddress = address);
                        },
                        vehicleCubit: cubit,
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
      return "${place.street}, ${place.locality}, ${place.country}";
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

  /// 🔸 لما مفيش عناوين
  Widget _buildEmptyLocationSheet(BuildContext context) {
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
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
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
                  context.read<VehicleCubit>().selectLocation(selectedAddress);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<VehicleCubit>(),
                        child: const VehicleOrderDetails(),
                      ),
                    ),
                  );
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
