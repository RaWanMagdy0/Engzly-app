import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData appTheme = ThemeData(
    scaffoldBackgroundColor: ColorsManager.white,
    appBarTheme: AppBarTheme(
      centerTitle: false,
      elevation: 0.0,
      backgroundColor: ColorsManager.white,
      titleTextStyle: AppFonts.font20BlackWeight700,
      toolbarTextStyle: AppFonts.font16BlackWeight400,
      iconTheme: const IconThemeData(color: ColorsManager.black),
      actionsIconTheme: const IconThemeData(color: ColorsManager.black),
    ),
  );
}
