import 'package:engzly/core/theming/colors.dart';
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
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.black,
      elevation: 0,
      toolbarHeight: 60.h,
      leading: Padding(
        padding: EdgeInsets.only(left: 16.w),
        child: IconButton(
          onPressed: onLeadingTap,
          icon: leadingIcon,
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
  Size get preferredSize => Size.fromHeight(60.h);
}
