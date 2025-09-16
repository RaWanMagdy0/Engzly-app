import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:engzly/core/helper/spacing.dart';
import 'package:engzly/core/theming/styles.dart';

class CustomLegendLabel extends StatelessWidget {
  const CustomLegendLabel({
    super.key,
    required this.degree,
    required this.backgroundColor,
    required this.typedegree,
  });
  final double degree;
  final Color backgroundColor;
  final String typedegree;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(backgroundColor: backgroundColor, maxRadius: 4),
        horizontalSpacing(5),
        Text(
          '$degree% $typedegree',
          style: TextStylesManager.font10WhiteMedium.copyWith(fontSize: 12.sp),
        ),
      ],
    );
  }
}
