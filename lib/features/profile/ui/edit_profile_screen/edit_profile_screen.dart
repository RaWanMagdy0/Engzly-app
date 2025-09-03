import 'package:engzly/core/routing/route_name.dart';
import 'package:engzly/core/shared_widgets/custom_scaffold.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/theming/images.dart';
import 'package:engzly/features/profile/ui/edit_profile_screen/widgets/edit_profile_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldScreen(
      title: Text(
        "Edit Profile ",
        style: AppFonts.font14BWhiteWeight700.copyWith(fontSize: 18.sp),
      ),
      leadingIcon: Icon(Icons.arrow_back, size: 28.w, color: Colors.white),
      notificationIcon:
          Image.asset(AppImages.notificationIcon, width: 28.w, height: 28.h),
      onLeadingTap: () {
        Navigator.pushNamed(context, RouteName.profile);
      },
      onNotificationTap: () {},
      showNotificationDot: true,
      child: Column(
        children: [
          30.verticalSpace,
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent, width: 2.w),
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: SvgPicture.asset(
              AppImages.profileIcon,
              width: 80.w,
              height: 80.h,
              colorFilter: ColorFilter.mode(
                ColorsManager.darkGray,
                BlendMode.srcIn,
              ),
            ),
          ),
          EditProfileForm(),
        ],
      ),
    );
  }
}
