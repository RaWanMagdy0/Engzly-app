import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final Widget leadingIcon;
  final Widget notificationIcon;
  final VoidCallback? onLeadingTap;
  final VoidCallback? onNotificationTap;
  final bool showNotificationDot;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.leadingIcon,
    required this.notificationIcon,
    this.onLeadingTap,
    this.onNotificationTap,
    this.showNotificationDot = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleTextStyle: AppFonts.font20BlackWeight700.copyWith(fontSize: 18.sp),
      iconTheme: const IconThemeData(color: ColorsManager.black),
      actionsIconTheme: const IconThemeData(color: ColorsManager.black),
      backgroundColor: Colors.white,
      forceMaterialTransparency: true,
      centerTitle: true,
      automaticallyImplyLeading: false,
      elevation: 0,
      toolbarHeight: 60.h,
      leading: Padding(
        padding: EdgeInsets.only(left: 16.w),
        child: IconButton(
          onPressed: onLeadingTap,
          icon: leadingIcon,
          color: ColorsManager.black,
        ),
      ),
      title: title,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 16.w),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                onPressed: onNotificationTap,
                icon: notificationIcon,
                color: ColorsManager.black,
              ),
              if (showNotificationDot)
                Positioned(
                  right: 10,
                  top: 10,
                  child: Container(
                    width: 6.w,
                    height: 6.h,
                    decoration: BoxDecoration(
                      color: ColorsManager.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50.h);
}
