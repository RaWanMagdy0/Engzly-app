import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/styles.dart';

// ignore: must_be_immutable
class CustomElevationButton extends StatelessWidget {
  CustomElevationButton({
    super.key,
    this.title,
    this.onPressed,
    this.style,
    this.backgroundColor,
    this.borderRadiusGeometry,
    this.heightOfButton,
    this.bodyOfButton,
    this.side,
    this.widthOfButton,
    this.overlayColor,
    this.borderColor,
    this.hasborderColor = false,
  });
  final String? title;

  Color? backgroundColor;
  Color? borderColor;
  bool hasborderColor;
  double? heightOfButton;
  double? widthOfButton;
  TextStyle? style;
  BorderRadiusGeometry? borderRadiusGeometry;
  Widget? bodyOfButton;
  BorderSide? side;
  Color? overlayColor;
  void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            hasborderColor
                ? ColorsManager.secendryColor
                : backgroundColor ?? ColorsManager.secendryColor,
        shape: RoundedRectangleBorder(
          side:
              hasborderColor
                  ? BorderSide(
                    color: borderColor ?? ColorsManager.primaryColor,
                    width: 1,
                  )
                  : BorderSide.none,
          borderRadius: borderRadiusGeometry ?? BorderRadius.circular(8.r),
        ),
        shadowColor: Colors.transparent,
        elevation: 0,
        overlayColor: overlayColor,
      ),
      onPressed: onPressed,
      child: SizedBox(
        width: widthOfButton ?? double.infinity,
        height: heightOfButton ?? 45.h,
        child:
            bodyOfButton ??
            Center(
              child: Text(
                title ?? "",
                style: style ?? TextStylesManager.font18DarkGrayMedium.copyWith(color: ColorsManager.white),
              ),
            ),
      ),
    );
  }
}
