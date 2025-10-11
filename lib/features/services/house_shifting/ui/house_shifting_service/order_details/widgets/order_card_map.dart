import 'dart:math' show cos, sin, sqrt, atan2, pi, max, min;
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class OrderCardMap extends StatefulWidget {
  final String? location;

  const OrderCardMap({super.key, this.location});

  @override
  State<OrderCardMap> createState() => _OrderCardMapState();
}

class _OrderCardMapState extends State<OrderCardMap> {
  LatLng? endPoint;
  late LatLng startPoint;
  GoogleMapController? mapController;
  bool isLoading = true;

  static const LatLng octoberStart = LatLng(29.9715, 30.9486); 

  @override
  void initState() {
    super.initState();
    _initMap();
  }

  Future<void> _initMap() async {
    try {
      debugPrint("📍 User address: ${widget.location}");

      startPoint = octoberStart;

      if (widget.location == null ||
          widget.location!.isEmpty ||
          widget.location!.trim().length < 3) {
        setState(() {
          endPoint = startPoint;
          isLoading = false;
        });
        return;
      }

      final locations = await locationFromAddress(widget.location!);
      if (locations.isNotEmpty) {
        final end = LatLng(locations.first.latitude, locations.first.longitude);

        setState(() {
          endPoint = end;
          isLoading = false;
        });

        WidgetsBinding.instance.addPostFrameCallback((_) {
          _fitMapToBounds();
        });
      } else {
        setState(() {
          endPoint = startPoint;
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("❌ Error getting coordinates: $e");
      setState(() {
        startPoint = octoberStart;
        endPoint = octoberStart;
        isLoading = false;
      });
    }
  }

  void _fitMapToBounds() {
    if (mapController == null || endPoint == null) return;

    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(
        min(startPoint.latitude, endPoint!.latitude),
        min(startPoint.longitude, endPoint!.longitude),
      ),
      northeast: LatLng(
        max(startPoint.latitude, endPoint!.latitude),
        max(startPoint.longitude, endPoint!.longitude),
      ),
    );

    mapController!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 60));
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (endPoint == null) {
      return const Center(child: Text("No map data available"));
    }

    final markers = <Marker>{
      Marker(
        markerId: const MarkerId('start'),
        position: startPoint,
        infoWindow: const InfoWindow(title: "Start Point (6th October)"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      ),
      Marker(
        markerId: const MarkerId('end'),
        position: endPoint!,
        infoWindow: InfoWindow(title: widget.location ?? "Destination"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      ),
    };

    final polyline = Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.orange,
      width: 4,
      points: [startPoint, endPoint!],
    );

    final distanceInMeters = _calculateDistanceInMeters(startPoint, endPoint!);
    final distanceText = distanceInMeters > 1000
        ? "${(distanceInMeters / 1000).toStringAsFixed(2)} km"
        : "${distanceInMeters.toStringAsFixed(0)} m";

    return SizedBox(
      height: 240.h,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: startPoint, zoom: 10),
              markers: markers,
              polylines: endPoint != startPoint ? {polyline} : {},
              onMapCreated: (controller) {
                mapController = controller;
                if (endPoint != startPoint) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _fitMapToBounds();
                  });
                }
              },
              zoomControlsEnabled: false,
              myLocationButtonEnabled: false,
              scrollGesturesEnabled: true,
              zoomGesturesEnabled: true,
              rotateGesturesEnabled: true,
              tiltGesturesEnabled: true,
              mapToolbarEnabled: false,
              liteModeEnabled: false,
              gestureRecognizers: {
                Factory<OneSequenceGestureRecognizer>(
                    () => EagerGestureRecognizer()),
              },
            ),
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.straighten, color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      distanceText,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _calculateDistanceInMeters(LatLng start, LatLng end) {
    const earthRadius = 6371000; 
    final dLat = (end.latitude - start.latitude) * (pi / 180);
    final dLon = (end.longitude - start.longitude) * (pi / 180);
    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(start.latitude * pi / 180) *
            cos(end.latitude * pi / 180) *
            sin(dLon / 2) *
            sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }
}
