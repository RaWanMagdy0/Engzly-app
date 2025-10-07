import 'package:engzly/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderCardMap extends StatelessWidget {
  const OrderCardMap({super.key});

  @override
  Widget build(BuildContext context) {
    const startLocation = LatLng(30.0444, 31.2357);
    const endLocation = LatLng(30.0480, 31.2400);

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
                  height: 170.h,
                  child: GoogleMap(
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(30.046, 31.237),
                      zoom: 14,
                    ),
                    markers: {
                      Marker(
                        markerId: const MarkerId("start"),
                        position: startLocation,
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueYellow),
                      ),
                      Marker(
                        markerId: const MarkerId("end"),
                        position: endLocation,
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueAzure),
                      ),
                    },
                    polylines: {
                      Polyline(
                        polylineId: const PolylineId("route"),
                        color: ColorsManager.orange,
                        width: 3,
                        points: [startLocation, endLocation],
                      ),
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
                right: 12.w,
                top: 12.h,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: const Offset(0, 2))
                    ],
                  ),
                  child: Text(
                    "847m",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLocationRow(
                  color: Colors.black,
                  address: "2045 Lodgeville Street, Eagan",
                ),
                SizedBox(height: 6.h),
                _buildLocationRow(
                  color: Colors.green,
                  address: "3329 Joyce Street, PA, USA",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationRow({required Color color, required String address}) {
    return Row(
      children: [
        Container(
          width: 12.w,
          height: 12.w,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            address,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
