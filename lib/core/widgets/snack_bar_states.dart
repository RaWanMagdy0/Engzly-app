import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:engzly/core/theming/colors.dart';

void showSnackBar(BuildContext context, String message, [Color? color]) {
  final snackBar = SnackBar(
    content: Center(
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    ),
    backgroundColor: color ?? ColorsManager.green,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    duration: const Duration(seconds: 3),
    margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
    elevation: 8,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
