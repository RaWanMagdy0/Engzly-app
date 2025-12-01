import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MapView extends StatelessWidget {
  final GoogleMapController? mapController;
  final LatLng? selectedLocation;
  final Set<Marker> markers;
  final double currentZoom;
  final Function(GoogleMapController) onMapCreated;
  final Function(LatLng) onMapTap;
  final Function(CameraPosition) onCameraMove;

  const MapView({
    super.key,
    required this.mapController,
    required this.selectedLocation,
    required this.markers,
    required this.currentZoom,
    required this.onMapCreated,
    required this.onMapTap,
    required this.onCameraMove,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(40.r),
        topRight: Radius.circular(40.r),
      ),
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: selectedLocation ?? const LatLng(30.0444, 31.2357),
          zoom: currentZoom,
        ),
        markers: markers,
        onTap: onMapTap,
        onCameraMove: onCameraMove,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        onMapCreated: onMapCreated,
      ),
    );
  }
}
