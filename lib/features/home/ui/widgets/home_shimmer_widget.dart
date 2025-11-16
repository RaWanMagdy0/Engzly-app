import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class HomeShimmerWidgets {
  static Widget shimmerWrapper(Widget child) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: child,
    );
  }

  static Widget buildTabsShimmer() {
    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        separatorBuilder: (_, __) => 8.horizontalSpace,
        itemBuilder: (_, __) => shimmerWrapper(
          Container(
            width: 70.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(15.r),
            ),
          ),
        ),
      ),
    );
  }

  static Widget buildOffersShimmer() {
    return SizedBox(
      height: 140.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        separatorBuilder: (_, __) => SizedBox(width: 12.w),
        itemBuilder: (_, __) => shimmerWrapper(
          Container(
            width: 260.w,
            height: 150.h,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
        ),
      ),
    );
  }

  static Widget buildOtherServicesTitleShimmer() {
    return shimmerWrapper(
      Container(
        width: 120.w,
        height: 20.h,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(6.r),
        ),
      ),
    );
  }

  static Widget buildServicesShimmer() {
    return SizedBox(
      height: 100.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        separatorBuilder: (_, __) => SizedBox(width: 15.w),
        itemBuilder: (context, index) => Column(
          children: [
            shimmerWrapper(
              CircleAvatar(
                radius: 35.r,
                backgroundColor: Colors.grey.shade200,
              ),
            ),
            6.verticalSpace,
            shimmerWrapper(
              Container(
                width: 60.w,
                height: 12.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
