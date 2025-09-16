import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewWidget extends StatelessWidget {
  final GoogleMapController? controller;
  final LatLng initialLocation;
  final Set<Marker> markers;
  final Function(LatLng) onTap;
  final Function(CameraPosition) onCameraMove;
  final Function(GoogleMapController)? onMapCreated; 

  const MapViewWidget({
    super.key,
    required this.controller,
    required this.initialLocation,
    required this.markers,
    required this.onTap,
    required this.onCameraMove,
    this.onMapCreated,
  });

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: initialLocation,
        zoom: 16,
      ),
      markers: markers,
      onTap: onTap,
      onCameraMove: onCameraMove,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      onMapCreated: onMapCreated, 
    );
  }
}

