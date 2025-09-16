import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/font_weight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class TextStylesManager {
  // ------------------------- font 8 ------------------------------//
  static TextStyle font8BlueRegular = TextStyle(
    color: ColorsManager.primaryColor,
    fontSize: 8.sp,
    fontWeight: FontWeightManager.regular,
  );
  //---------------------------- font 10-----------------------------//
  static TextStyle font10WhiteMedium = TextStyle(
    color: ColorsManager.white,
    fontSize: 10.sp,
    fontWeight: FontWeightManager.medium,
  );
  static TextStyle font18DarkGrayMedium = TextStyle(
    color: ColorsManager.darkGray,
    fontSize: 18.sp,
    fontWeight: FontWeightManager.medium,
  );
}
