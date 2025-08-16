import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/styles.dart';

// ignore: must_be_immutable
class CustomBorderOnlyButton extends StatelessWidget {
  CustomBorderOnlyButton({
    super.key,
    this.title,
    this.onPressed,
    this.style,
    this.borderRadiusGeometry,
    this.heightOfButton,
    this.bodyOfButton,
    this.widthOfButton,
    this.overlayColor,
    this.borderColor,
    this.borderWidth = 1,
  });

  final String? title;
  void Function()? onPressed;
  Color? borderColor;
  double borderWidth;
  double? heightOfButton;
  double? widthOfButton;
  TextStyle? style;
  BorderRadiusGeometry? borderRadiusGeometry;
  Widget? bodyOfButton;
  Color? overlayColor;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        side: BorderSide(
          color: borderColor ?? ColorsManager.primaryColor,
          width: borderWidth,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: borderRadiusGeometry ?? BorderRadius.circular(8.r),
        ),
        shadowColor: Colors.transparent,
      ),
      onPressed: onPressed,
      child: SizedBox(
        width: widthOfButton ?? double.infinity,
        height: heightOfButton ?? 40.h,
        child:
            bodyOfButton ??
            Center(
              child: Text(
                title ?? "",
                style:
                    style ??
                    TextStylesManager.font18DarkGrayMedium.copyWith(
                      color: borderColor ?? ColorsManager.secendryColor,
                    ),
              ),
            ),
      ),
    );
  }
}
