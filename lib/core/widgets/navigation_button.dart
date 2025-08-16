import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:engzly/core/helper/spacing.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/styles.dart';

class NavigationButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final bool isBack;

  const NavigationButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
    this.isBack = false,
  });

  @override
  Widget build(BuildContext context) {
    final child = Row(
      mainAxisSize: MainAxisSize.min,
      children:
          isBack
              ? [Text(label, style: TextStylesManager.font18DarkGrayMedium)]
              : [
                Text(label, style: TextStylesManager.font18DarkGrayMedium.copyWith(color: ColorsManager.white)),
                horizontalSpacing(6),
                Icon(icon, size: 16.sp, color: foregroundColor),
              ],
    );

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isBack ? Colors.transparent : ColorsManager.secendryColor,
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      ),
      child: child,
    );
  }
}
