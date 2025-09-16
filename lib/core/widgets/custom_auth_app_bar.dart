import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:engzly/core/theming/styles.dart';

class CustomAuthAppBar extends StatelessWidget {
  const CustomAuthAppBar({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Image.asset('assets/images/arrow_back.png', width: 19.w),
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
    );
  }
}
