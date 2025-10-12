import 'package:engzly/features/services/cleaning/logic/cleaning_cubit.dart';
import 'package:engzly/features/services/cleaning/ui/cleaning/third_screen/widgets/location_bottom_sheet.dart';
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
import 'widgets/map_view.dart';
import 'widgets/address_top_bar.dart';

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
    _initializeMap();
  }

  @override
  Widget build(BuildContext context) {
    final cleaningCubit = context.read<CleaningCubit>();

    return CustomScaffoldScreen(
      showNotificationDot: true,
      title: Text(
        "Confirm Location",
        style: AppFonts.font14BWhiteWeight700.copyWith(fontSize: 18.sp),
      ),
      leadingIcon:
          SvgPicture.asset(AppImages.backArrow, width: 30.w, height: 30.h),
      notificationIcon:
          Image.asset(AppImages.notificationIcon, width: 28.w, height: 28.h),
      onLeadingTap: () => Navigator.pop(context),
      child: Stack(
        children: [
          Positioned.fill(
            child: MapView(
              mapController: _mapController,
              selectedLocation: selectedLocation,
              markers: _markers,
              currentZoom: currentZoom,
              onMapCreated: (controller) => _mapController = controller,
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
          CleaningLocationBottomSheet(
            selectedAddress: selectedAddress,
            selectedType: selectedType,
            onTypeChanged: (type) async {
              setState(() => selectedType = type);
            },
            onConfirm: () {
              cleaningCubit.selectLocation(selectedAddress);
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
  }
}
