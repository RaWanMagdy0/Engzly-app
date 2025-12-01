import 'package:engzly/features/services/cleaning/data/models/response/location_response/location_model.dart';
import 'package:engzly/features/services/cleaning/logic/cleaning_cubit.dart';
import 'package:engzly/features/services/cleaning/logic/cleaning_states.dart';
import 'package:engzly/features/services/cleaning/ui/ui/location_screen/widgets/cleaning_location_bottom_sheet.dart';
import 'package:engzly/features/services/cleaning/ui/ui/location_screen/widgets/empty_locatiom_bottom_sheet.dart' show CleaningEmptyLocationSheet;
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
import 'widgets/cleaning_address_top_bar.dart';

class CleaningChooseLocation extends StatefulWidget {
  const CleaningChooseLocation({super.key});

  @override
  State<CleaningChooseLocation> createState() => _CleaningChooseLocationState();
}

class _CleaningChooseLocationState extends State<CleaningChooseLocation> {
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};
  LatLng? selectedLocation;
  double currentZoom = 16.0;
  String selectedAddress = "Cairo, Egypt";
  String selectedType = "home";

  @override
  void initState() {
    super.initState();
    context.read<CleaningCubit>().getLocations();
    _initializeMap();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CleaningCubit, CleaningStates>(
      listener: (context, state) {
        if (state is CleaningLocationsError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final cubit = context.read<CleaningCubit>();
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
                child: GoogleMap(
                  onMapCreated: (controller) => _mapController = controller,
                  initialCameraPosition: CameraPosition(
                    target: selectedLocation ?? const LatLng(30.0444, 31.2357),
                    zoom: currentZoom,
                  ),
                  markers: _markers,
                  onTap: _handleMapTap,
                  onCameraMove: (pos) => currentZoom = pos.zoom,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                ),
              ),

              Positioned(
                top: 20.h,
                left: 16.w,
                right: 16.w,
                child: CleaningAddressTopBar(address: selectedAddress),
              ),

              if (state is! CleaningLocationsLoading)
                (locations.isNotEmpty
                    ? _buildLocationsBottomSheet(cubit, locations)
                    : CleaningEmptyLocationSheet(
                        selectedAddress: selectedAddress,
                        cleaningCubit: cubit,
                      )),
              if (state is CleaningLocationsLoading)
                const Center(
                  child: CircularProgressIndicator(color: ColorsManager.green),
                ),
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
          infoWindow: InfoWindow(title: address),
          draggable: true,
          onDragEnd: (newPosition) async {
            String newAddress = await _getDetailedAddress(newPosition);
            _updateMarker(newPosition, newAddress);
          },
        ),
      );
    });
  }

  Widget _buildLocationsBottomSheet(
      CleaningCubit cubit, List<LocationModel> locations) {
    return CleaningLocationBottomSheet(
      selectedAddress: selectedAddress,
      selectedType: selectedType,
      cleaningCubit: cubit,
      locations: locations,
      onTypeChanged: (type) => setState(() => selectedType = type),
      onSelectAddress: (address) => setState(() => selectedAddress = address),
    );
  }
}