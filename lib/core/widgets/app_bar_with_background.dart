import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/styles.dart';

class AppBarWithBackground extends StatelessWidget {
  const AppBarWithBackground({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      decoration: BoxDecoration(
        color: ColorsManager.secendryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Stack(
            alignment: Alignment.center,
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    'assets/images/arrow_back.png',
                    width: 19.w,
                    color: ColorsManager.white,
                  ),
                ),
              ),
              Center(
                child: Text(
                  title,
                  style: TextStylesManager.font18DarkGrayMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
