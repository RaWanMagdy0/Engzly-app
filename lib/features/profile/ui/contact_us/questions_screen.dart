import 'package:engzly/core/shared_widgets/custom_scaffold.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/theming/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldScreen(
      title: Text(
        "FAQs",
        style: AppFonts.font14BWhiteWeight700.copyWith(fontSize: 18.sp),
      ),
      leadingIcon:
          SvgPicture.asset(AppImages.categoryIcon, width: 22.w, height: 22.h),
      notificationIcon:
          Image.asset(AppImages.notificationIcon, width: 28.w, height: 28.h),
      onLeadingTap: () {},
      onNotificationTap: () {},
      showNotificationDot: true,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.verticalSpace,
          ],
        ),
      ),
    );
  }
}
