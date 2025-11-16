import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/notification/notification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final Widget leadingIcon;
  final Widget notificationIcon;
  final VoidCallback? onLeadingTap;
  final VoidCallback? onNotificationTap;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.leadingIcon,
    required this.notificationIcon,
    this.onLeadingTap,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasUnread = context.watch<NotificationCubit>().hasUnread;

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
              if (hasUnread)
                Positioned(
                  right: 10,
                  top: 10,
                  child: Container(
                    width: 8.w,
                    height: 8.h,
                    decoration: const BoxDecoration(
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
