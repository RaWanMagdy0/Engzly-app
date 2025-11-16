import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SimpleMapView extends StatelessWidget {
  final GoogleMapController? mapController;
  final LatLng? selectedLocation;
  final Set<Marker> markers;
  final double currentZoom;
  final Function(GoogleMapController) onMapCreated;
  final Function(LatLng) onMapTap;
  final Function(CameraPosition) onCameraMove;

  const SimpleMapView({
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
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: selectedLocation ?? const LatLng(30.0444, 31.2357),
        zoom: currentZoom,
      ),
      markers: markers,
      onTap: onMapTap,
      onCameraMove: onCameraMove,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      onMapCreated: onMapCreated,
    );
  }
}
