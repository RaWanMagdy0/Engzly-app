import 'package:engzly/core/theming/fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HistoryServiceCard extends StatelessWidget {
  final String status;
  final String serviceName;
  final String schedule;
  final double totalPrice;

  const HistoryServiceCard({
    super.key,
    required this.status,
    required this.serviceName,
    required this.schedule,
    required this.totalPrice,
  });

  Color getStatusColor() {
    switch (status.toLowerCase()) {
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
    final staticLocation = const LatLng(30.0444, 31.2357);

    return Card(
      color: ColorsManager.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                ),
                child: SizedBox(
                  height: 150.h,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: staticLocation,
                      zoom: 14,
                    ),
                    markers: {
                      Marker(
                        markerId: const MarkerId("service_location"),
                        position: staticLocation,
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
              ),
              Positioned(
                top: 12.h,
                left: 10.w,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: getStatusColor(),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(status, style: AppFonts.font14BWhiteWeight700),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(serviceName,
                    style: AppFonts.font20BlackWeight700
                        .copyWith(fontSize: 16.sp)),
                4.verticalSpace,
                Text(
                  schedule,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.sp,
                  ),
                ),
                Divider(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: Colors.green,
                          size: 18.sp,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          "Service Location",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "EGP ${totalPrice.toStringAsFixed(0)}",
                      style: TextStyle(
                        color: ColorsManager.orange,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
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
