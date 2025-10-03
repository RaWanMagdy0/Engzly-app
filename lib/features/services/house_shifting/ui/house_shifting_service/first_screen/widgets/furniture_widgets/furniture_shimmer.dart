import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class FurnitureShimmer extends StatelessWidget {
  const FurnitureShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: CircleAvatar(
            radius: 30.r,
            backgroundColor: Colors.grey,
          ),
        ),
        8.verticalSpace,
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 12.h,
            width: 50.w,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
