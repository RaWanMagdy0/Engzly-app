import 'package:engzly/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppFonts {
  static TextStyle font20BlackWeight700 = TextStyle(
    fontSize: 20.sp,
    color: ColorsManager.black,
    fontWeight: FontWeight.w700,
  );
  static TextStyle font36BlackWeight700 = TextStyle(
    fontSize: 34.sp,
    color: ColorsManager.black,
    fontWeight: FontWeight.w700,
  );
  static TextStyle font16BlackWeight400 = TextStyle(
    fontSize: 16.sp,
    color: ColorsManager.black,
    fontWeight: FontWeight.w400,
  );
  static TextStyle font14BWhiteWeight700 = TextStyle(
    fontSize: 14.sp,
    color: ColorsManager.white,
    fontWeight: FontWeight.w700,
  );
  static TextStyle font12BWhiteWeight500 = TextStyle(
    fontSize: 12.sp,
    color: ColorsManager.white,
    fontWeight: FontWeight.w500,
  );
  static TextStyle font14BOrangeWeight400 = TextStyle(
    fontSize: 14.sp,
    color: ColorsManager.orange,
    fontWeight: FontWeight.w400,
  );
  static TextStyle font13BlackWeight500 = TextStyle(
    fontSize: 13.sp,
    color: ColorsManager.black,
    fontWeight: FontWeight.w500,
  );

  static TextStyle font12BlackWeight400 = TextStyle(
    fontSize: 12.sp,
    color: ColorsManager.black,
    fontWeight: FontWeight.w400,
  );

   static TextStyle font24greykWeight400 = TextStyle(
    fontSize: 24.sp,
    color: ColorsManager.black.withValues(alpha: 0.5),
    fontWeight: FontWeight.w400,
  );
}
