import 'package:engzly/features/profile/data/models/get_address/location_model.dart';
import 'package:engzly/features/services/cleaning/logic/cleaning_cubit.dart';
import 'package:engzly/features/services/cleaning/logic/cleaning_states.dart';
import 'package:engzly/features/services/cleaning/ui/cleaning/third_screen/widgets/cleaning_location_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:engzly/core/shared_widgets/custom_scaffold.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/theming/images.dart';
import 'package:engzly/core/theming/colors.dart';
import 'widgets/map_view.dart';
import 'widgets/cleaning_address_top_bar.dart';

class CleaningChooseLocation extends StatefulWidget {
  const CleaningChooseLocation({super.key});

  @override
  State<CleaningChooseLocation> createState() => _CleaningChooseLocation();
}

class _CleaningChooseLocation extends State<CleaningChooseLocation> {
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
          showNotificationDot: true,
          title: Text(
            "Confirm Location",
            style: AppFonts.font14BWhiteWeight700.copyWith(fontSize: 18.sp),
          ),
          leadingIcon:
              SvgPicture.asset(AppImages.backArrow, width: 30.w, height: 30.h),
          notificationIcon: Image.asset(AppImages.notificationIcon,
              width: 28.w, height: 28.h),
          onLeadingTap: () {
            Navigator.pop(context);
          },
          child: Stack(
            children: [
              if (state is CleaningLocationsLoading)
                const Center(
                  child: CircularProgressIndicator(
                    color: ColorsManager.green,
                  ),
                )
              else
                Positioned.fill(
                  child: MapView(
                    mapController: _mapController,
                    selectedLocation: selectedLocation,
                    markers: _markers,
                    currentZoom: currentZoom,
                    onMapCreated: (controller) {
                      _mapController = controller;
                    },
                    onMapTap: _handleMapTap,
                    onCameraMove: (pos) => currentZoom = pos.zoom,
                  ),
                ),
              Positioned(
                top: 20.h,
                left: 16.w,
                right: 16.w,
                child: CleaningAddressTopBar(address: selectedAddress),
              ),
              if (locations.isNotEmpty)
                CleaningLocationBottomSheet(
                  selectedAddress: selectedAddress,
                  selectedType: selectedType,
                  onTypeChanged: (type) async {
                    setState(() => selectedType = type);
                    await _moveToSavedLocation(type, locations);
                  },
                  onSelectAddress: (_) {},
                  cleaningCubit: context.read<CleaningCubit>(),
                ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _initializeMap() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        // ignore: deprecated_member_use
        desiredAccuracy: LocationAccuracy.high,
      );
      selectedLocation = LatLng(position.latitude, position.longitude);
      String address = await _getDetailedAddress(selectedLocation!);
      _updateMarker(selectedLocation!, address);
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
    if (selectedType == "add new") {
      selectedLocation = location;
      String address = await _getDetailedAddress(location);
      _updateMarker(location, address);
    }
  }

  Future<void> _moveToSavedLocation(
      String type, List<LocationModel> locations) async {
    final filtered = locations
        .where((loc) => loc.type.toLowerCase() == type.toLowerCase())
        .toList();

    if (filtered.isNotEmpty) {
      final loc = filtered.first;
      final address = loc.location;

      try {
        List<Location> locationsList = await locationFromAddress(address);

        if (locationsList.isNotEmpty) {
          final newPos = LatLng(
            locationsList.first.latitude,
            locationsList.first.longitude,
          );

          _updateMarker(newPos, address);

          _mapController?.animateCamera(
            CameraUpdate.newLatLngZoom(newPos, currentZoom),
          );
        }
      } catch (e) {
        debugPrint(" Failed to get location for address: $address");
      }
    }
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
        ),
      );
    });
  }
}
