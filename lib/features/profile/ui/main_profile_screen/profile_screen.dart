import 'package:engzly/core/shared_widgets/custom_scaffold.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/features/profile/ui/main_profile_screen/widgets/general_data_widget.dart';
import 'package:engzly/features/profile/ui/main_profile_screen/widgets/more_widget.dart';
import 'package:engzly/features/profile/ui/main_profile_screen/widgets/notification_widget.dart';
import 'package:engzly/features/profile/ui/main_profile_screen/widgets/user_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:engzly/core/theming/images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldScreen(
      title: Text(
        "Profile ",
        style: AppFonts.font14BWhiteWeight700.copyWith(fontSize: 18.sp),
      ),
      leadingIcon:
          SvgPicture.asset(AppImages.categoryIcon, width: 22.w, height: 22.h),
      notificationIcon:
          Image.asset(AppImages.notificationIcon, width: 28.w, height: 28.h),
      onLeadingTap: () {},
      onNotificationTap: () {},
      showNotificationDot: true,
      child: Column(
        children: [
          UserDataWidget(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GeneralDataWidget(),
                  NotificationWidget(),
                  MoreWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
