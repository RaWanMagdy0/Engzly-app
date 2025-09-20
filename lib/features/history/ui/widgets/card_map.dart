// lib/widgets/service_card_map.dart
import 'package:engzly/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ServiceCardMap extends StatefulWidget {
  final String status;
  final String title;
  final String date;
  final String address;
  final LatLng location;

  const ServiceCardMap({
    super.key,
    required this.status,
    required this.title,
    required this.date,
    required this.address,
    required this.location,
  });

  @override
  State<ServiceCardMap> createState() => _ServiceCardMapState();
}

class _ServiceCardMapState extends State<ServiceCardMap> {
  GoogleMapController? _mapController;

  Color getStatusColor() {
    switch (widget.status) {
      case "Active":
        return Colors.green;
      case "Cancelled":
        return Colors.red;
      case "Done":
        return Colors.black;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorsManager.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: SizedBox(
                  height: 150,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: widget.location,
                      zoom: 14,
                    ),
                    onMapCreated: (controller) {
                      _mapController = controller;
                    },
                    markers: {
                      Marker(
                        markerId: const MarkerId("service_location"),
                        position: widget.location,
                      )
                    },
                    zoomControlsEnabled: false,
                    myLocationButtonEnabled: false,
                    scrollGesturesEnabled: false,
                    tiltGesturesEnabled: false,
                    rotateGesturesEnabled: false,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  decoration: BoxDecoration(
                    color: getStatusColor(),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    widget.status,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(widget.date, style: const TextStyle(color: Colors.grey)),
                const Divider(),
                Row(
                  children: [
                    const Icon(Icons.location_pin,
                        color: Colors.green, size: 18),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(widget.address,
                          style: const TextStyle(color: Colors.black54)),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
