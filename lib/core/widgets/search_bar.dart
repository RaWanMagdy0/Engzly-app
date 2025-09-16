import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/styles.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key, required this.hintText});
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 12.0.h,
            horizontal: 16.0.w,
          ),
          hintText: hintText,
          filled: true,
          fillColor: const Color(0xffECECEC),
          hintStyle: TextStylesManager.font10WhiteMedium,
          prefixIcon: const Icon(Icons.search_rounded),
          prefixIconColor: ColorsManager.darkGray,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(color: ColorsManager.darkGray),
          ),
        ),
      ),
    );
  }
}
