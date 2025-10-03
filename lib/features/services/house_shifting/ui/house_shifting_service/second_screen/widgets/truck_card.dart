import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TruckCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final bool isSelected;

  const TruckCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 125.w,
      height: 160.h,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            imageUrl,
            height: 60.h,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => const Icon(Icons.local_shipping),
          ),
          10.verticalSpace,
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
          4.verticalSpace,
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12.sp,
              color: isSelected ? Colors.white70 : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
