import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:engzly/core/theming/colors.dart';

class VehicleShimmer extends StatelessWidget {
  const VehicleShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(
            color: ColorsManager.lightGray,
            width: 1,
          ),
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 70.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            8.verticalSpace,
            Container(
              height: 14.h,
              width: 80.w,
              color: Colors.grey,
            ),
            5.verticalSpace,
            Container(
              height: 12.h,
              width: 60.w,
              color: Colors.grey,
            ),
            5.verticalSpace,
            Container(
              height: 14.h,
              width: 40.w,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
