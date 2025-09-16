import 'package:flutter/material.dart';
import 'package:engzly/core/helper/spacing.dart';
import 'package:engzly/core/theming/styles.dart';

class CustomTitleAndSubTitile extends StatelessWidget {
  const CustomTitleAndSubTitile({
    super.key,
    required this.title,
    required this.subTitle,
  });
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStylesManager.font18DarkGrayMedium),
        verticalSpacing(4),
        Text(subTitle, style: TextStylesManager.font18DarkGrayMedium),
      ],
    );
  }
}
