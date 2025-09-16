import 'package:engzly/core/theming/colors.dart';
import 'package:flutter/material.dart';

class CustomCircularIndecator extends StatelessWidget {
  const CustomCircularIndecator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: ColorsManager.secendryColor),
    );
  }
}
