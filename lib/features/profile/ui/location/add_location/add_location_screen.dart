// ignore_for_file: deprecated_member_use

import 'package:engzly/core/shared_widgets/custom_scaffold.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/theming/images.dart';
import 'package:engzly/features/profile/logic/cubit.dart';
import 'package:engzly/features/profile/logic/state.dart';
import 'package:engzly/features/profile/ui/location/add_location/widgets/location_bottom_sheet.dart';
import 'package:engzly/features/profile/ui/location/add_location/widgets/location_tab_bar.dart';
import 'package:engzly/features/profile/ui/location/add_location/widgets/map_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddLocationScreen extends StatefulWidget {
  const AddLocationScreen({super.key});

  @override
  State<AddLocationScreen> createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};
  LatLng? selectedLocation;
  double currentZoom = 16.0;
  String selectedAddress = "Cairo, Egypt";
  late ProfileCubit viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = context.read<ProfileCubit>();
    _initializeMap();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldScreen(
      showNotificationDot: true,
      title: Text(
        "Select Location",
        style: AppFonts.font14BWhiteWeight700.copyWith(fontSize: 18.sp),
      ),
      leadingIcon:
          SvgPicture.asset(AppImages.categoryIcon, width: 22.w, height: 22.h),
      notificationIcon:
          Image.asset(AppImages.notificationIcon, width: 28.w, height: 28.h),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is SelectLocationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              backgroundColor: ColorsManager.green,
            ));
          } else if (state is SelectLocationError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.r),
                    topRight: Radius.circular(40.r),
                  ),
                  child: MapViewWidget(
                    controller: _mapController,
                    initialLocation:
                        selectedLocation ?? const LatLng(30.0444, 31.2357),
                    markers: _markers,
                    onTap: _handleMapTap,
                    onCameraMove: (pos) => currentZoom = pos.zoom,
                    onMapCreated: (controller) {
                      _mapController = controller;
                      if (selectedLocation != null) {
                        _mapController!.animateCamera(
                          CameraUpdate.newLatLngZoom(
                              selectedLocation!, currentZoom),
                        );
                      }
                    },
                  ),
                ),
              ),
              Positioned(
                top: 30,
                left: 16,
                right: 16,
                child: LocationTopBar(address: selectedAddress),
              ),
            ],
          );
        },
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

      if (_mapController != null) {
        _mapController!.animateCamera(
          CameraUpdate.newLatLngZoom(selectedLocation!, currentZoom),
        );
      }
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

    _showLocationTypeSheet(address);
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
    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(location, currentZoom),
    );
  }

  void _showLocationTypeSheet(String address) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (context) {
        return LocationBottomSheet(
          address: address,
          onProceed: (type) {
            viewModel.addLocation(location: address, type: type);
          },
        );
      },
    );
  }
}
