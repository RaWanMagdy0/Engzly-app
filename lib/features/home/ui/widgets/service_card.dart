import 'package:engzly/core/theming/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceCard extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconBackgroundColor;
  final Color iconColor;
  final String title;

  const ServiceCard({
    super.key,
    required this.icon,
    required this.backgroundColor,
    required this.iconBackgroundColor,
    required this.iconColor,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 28.r,
            backgroundColor: iconBackgroundColor,
            child: Icon(icon, size: 30.sp, color: iconColor),
          ),
          8.verticalSpace,
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppFonts.font14BWhiteWeight700.copyWith(
              color: Colors.black87,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
