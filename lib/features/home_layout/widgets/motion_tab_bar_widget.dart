import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';

class MotionTabBarWidget extends StatefulWidget {
  final MotionTabBarController controller;
  const MotionTabBarWidget({super.key, required this.controller});
  @override
  State<MotionTabBarWidget> createState() => _MotionTabBarWidgetState();
}

class _MotionTabBarWidgetState extends State<MotionTabBarWidget> {
  @override
  Widget build(BuildContext context) {
    return MotionTabBar(
      controller: widget.controller,
      initialSelectedTab: "Home",
      labels: const ["Home", "History", "Offers", "Profile"],
      icons: const [
        Icons.home,
        Icons.description,
        //  Icons.confirmation_num,
        //  Icons.card_giftcard,
        Icons.local_activity,
        Icons.person,
      ],
      tabBarHeight: 55.h,
      tabSize: 50.w,
      tabIconSize: 28.sp,
      tabIconSelectedSize: 28.sp,
      tabSelectedColor: ColorsManager.white,
      tabIconSelectedColor: ColorsManager.orange,
      tabIconColor: ColorsManager.white,
      textStyle: AppFonts.font12BWhiteWeight500,
      tabBarColor: ColorsManager.black,
      onTabItemSelected: (int index) {
        setState(() {
          widget.controller.index = index;
        });
      },
    );
  }
}
