import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/features/onBoarding/widgets/onboarding_content.dart';
import 'package:engzly/features/onBoarding/widgets/image_widget.dart';
import 'package:engzly/features/onBoarding/widgets/indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomScreen extends StatelessWidget {
  const CustomScreen({
    super.key,
    required this.image,
    required this.caption,
    required this.mainText,
    required this.onSkip,
    required this.onNext,
    required this.isLastPage,
    required this.pageController,
    required this.pagesCount,
    required this.currentPage,
  });
  final String image;
  final String mainText;
  final String caption;
  final VoidCallback? onSkip;
  final VoidCallback? onNext;
  final bool isLastPage;
  final PageController pageController;
  final int pagesCount;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ImageWidget(image: image, onSkip: onSkip),
        50.verticalSpace,

        OnboardingContent(mainText: mainText, caption: caption),
        60.verticalSpace,

        Indicator(pageController: pageController, pagesCount: pagesCount),
        30.verticalSpace,
        CustomButton(
          onPressed: onNext,
          width: 290.w,
          height: 55.h,
          borderRadius: 16.r,
          text: isLastPage ? "Get Started" : "Next",
          textStyle: AppFonts.font14BWhiteWeight700,
          backgroundColor: ColorsManager.orange,
        ),
      ],
    );
  }
}
