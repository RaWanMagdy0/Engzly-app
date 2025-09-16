import 'package:engzly/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.pageController,
    required this.pagesCount,
  });

  final PageController pageController;
  final int pagesCount;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: pageController,
      count: pagesCount,
      effect: ExpandingDotsEffect(
        dotWidth: 10.w,
        dotHeight: 10.h,
        spacing: 5.w,
        activeDotColor: ColorsManager.orange,
        dotColor: ColorsManager.black.withValues(alpha: 0.5),
      ),
    );
  }
}
