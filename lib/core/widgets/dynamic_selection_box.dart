import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/styles.dart';

class DynamicSelectionBox extends StatelessWidget {
  const DynamicSelectionBox({
    super.key,
    required this.day,
    required this.isSelected,
    required this.onTap,
  });

  final bool isSelected;
  final String day;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.w),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.linear,
          width: isSelected ? 100.w : 90.w,
          padding: EdgeInsets.all(4.r),
          decoration: BoxDecoration(
            color: isSelected ? ColorsManager.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: ColorsManager.primaryColor, width: 1.w),
          ),
          child: Center(
            child: Text(
              day,
              style:
                  isSelected
                      ? TextStylesManager.font10WhiteMedium
                      : TextStylesManager.font10WhiteMedium,
            ),
          ),
        ),
      ),
    );
  }
}
