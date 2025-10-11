import 'package:engzly/core/theming/fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';

class HistoryServiceCard extends StatefulWidget {
  final String status;
  final String serviceName;
  final String schedule;
  final double totalPrice;
  final String locaion;
  const HistoryServiceCard({
    super.key,
    required this.status,
    required this.serviceName,
    required this.schedule,
    required this.totalPrice,
    required this.locaion,
  });

  @override
  State<HistoryServiceCard> createState() => _HistoryServiceCardState();
}

class _HistoryServiceCardState extends State<HistoryServiceCard> {
  LatLng? locationPoint;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getLocationCoordinates();
  }

  Future<void> _getLocationCoordinates() async {
    try {
      if (widget.locaion.isEmpty) {
        setState(() {
          locationPoint = const LatLng(30.0444, 31.2357);
          isLoading = false;
        });
        return;
      }

      final locations = await locationFromAddress(widget.locaion);
      if (locations.isNotEmpty) {
        setState(() {
          locationPoint =
              LatLng(locations.first.latitude, locations.first.longitude);
          isLoading = false;
        });
      } else {
        setState(() {
          locationPoint = const LatLng(30.0444, 31.2357);
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint(" Error getting coordinates for ${widget.locaion}: $e");
      setState(() {
        locationPoint = const LatLng(30.0444, 31.2357);
        isLoading = false;
      });
    }
  }

  Color getStatusColor() {
    switch (widget.status.toLowerCase()) {
      case "active":
        return Colors.green;
      case "cancelled":
        return Colors.red;
      case "done":
        return Colors.black;
      case "pending":
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorsManager.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 150.h,
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.r),
                          topRight: Radius.circular(16.r),
                        ),
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: locationPoint!,
                            zoom: 14,
                          ),
                          markers: {
                            Marker(
                              markerId: const MarkerId("service_location"),
                              position: locationPoint!,
                              infoWindow: InfoWindow(title: widget.locaion),
                            )
                          },
                          zoomControlsEnabled: false,
                          myLocationButtonEnabled: false,
                          scrollGesturesEnabled: false,
                          tiltGesturesEnabled: false,
                          rotateGesturesEnabled: false,
                          zoomGesturesEnabled: false,
                          mapToolbarEnabled: false,
                          liteModeEnabled: true,
                        ),
                      ),
                      Positioned(
                        top: 12.h,
                        left: 10.w,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.h, horizontal: 12.w),
                          decoration: BoxDecoration(
                            color: getStatusColor(),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(widget.status,
                              style: AppFonts.font14BWhiteWeight700),
                        ),
                      ),
                    ],
                  ),
          ),
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.serviceName,
                    style: AppFonts.font20BlackWeight700
                        .copyWith(fontSize: 16.sp)),
                4.verticalSpace,
                Text(
                  widget.schedule,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.sp,
                  ),
                ),
                Divider(height: 16.h),
                Row(
                  children: [
                    Icon(Icons.location_pin,
                        color: ColorsManager.green, size: 20.sp),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(
                        widget.locaion,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14.sp,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                    ),
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
