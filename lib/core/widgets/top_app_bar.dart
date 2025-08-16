import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/styles.dart' show TextStylesManager;

class TopAppBar extends StatelessWidget {
  const TopAppBar({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Container(
              width: 35.w,
              height: 33.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(color: ColorsManager.darkGray, width: 0.8.w),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 11.h, horizontal: 11.w),
                child: Image.asset('assets/images/pngs/arrow_back_icon.png'),
              ),
            ),
          ),
        ),
        Text(title, style: TextStylesManager.font10WhiteMedium),
        SizedBox(width: 35.w, height: 33.h),
      ],
    );
  }
}
