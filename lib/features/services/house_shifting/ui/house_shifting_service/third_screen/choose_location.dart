import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import 'package:engzly/core/shared_widgets/custom_scaffold.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/theming/images.dart';

import 'widgets/map_view.dart';
import 'widgets/address_top_bar.dart';
import 'widgets/location_bottom_sheet.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};
  LatLng? selectedLocation;
  double currentZoom = 16.0;
  String selectedAddress = "Cairo, Egypt";
  String selectedType = "home";

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldScreen(
      showNotificationDot: true,
      title: Text(
        "Confirm Location",
        style: AppFonts.font14BWhiteWeight700.copyWith(fontSize: 18.sp),
      ),
      leadingIcon:
          SvgPicture.asset(AppImages.categoryIcon, width: 22.w, height: 22.h),
      notificationIcon:
          Image.asset(AppImages.notificationIcon, width: 28.w, height: 28.h),
      child: Stack(
        children: [
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
            top: 30,
            left: 16,
            right: 16,
            child: AddressTopBar(address: selectedAddress),
          ),
          LocationBottomSheet(
            selectedAddress: selectedAddress,
            selectedType: selectedType,
            onTypeChanged: (type) {
              setState(() {
                selectedType = type;
              });
            },
          ),
        ],
      ),
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
    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(location, currentZoom),
    );
  }
}
