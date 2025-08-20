import 'package:engzly/core/shared_widgets/custom_scaffold.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:flutter/material.dart';
import 'package:engzly/core/theming/images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldScreen(
      title: Text(
        "Profile ",
        style: AppFonts.font14BWhiteWeight700.copyWith(fontSize: 18.sp),
      ),
      leadingIcon: AppImages.categoryIcon,
      notificationIcon: AppImages.notificationIcon,
      onLeadingTap: () {},
      onNotificationTap: () {},
      showNotificationDot: true,
      child: Column(
        children: [
          Text("Profile Screen", style: AppFonts.font16BlackWeight400),
        ],
      ),
    );
  }
}
