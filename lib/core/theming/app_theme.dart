import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData appTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.kWhite,
    appBarTheme: AppBarTheme(
      centerTitle: false,
      elevation: 0.0,
      backgroundColor: AppColors.kWhite,
      titleTextStyle: AppFonts.font20BlackWeight700,
    ),
  );
}
