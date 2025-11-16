import 'package:engzly/core/shared_widgets/custom_scaffold.dart';
import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/theming/images.dart';
import 'package:engzly/notification/notification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldScreen(
      title: Text(
        "NOTIFICATIONS",
        style: AppFonts.font14BWhiteWeight700.copyWith(
          fontSize: 18.sp,
          color: ColorsManager.black,
        ),
      ),
      leadingIcon: SvgPicture.asset(
        AppImages.backArrow,
        width: 30.w,
        height: 30.h,
        color: ColorsManager.black,
      ),
      notificationIcon: Image.asset(
        AppImages.notificationIcon,
        width: 28.w,
        height: 28.h,
        color: ColorsManager.white,
      ),
      onLeadingTap: () {
        Navigator.pop(context);
      },
      onNotificationTap: () {},
      child: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          final cubit = context.read<NotificationCubit>();
          final notifications = cubit.notifications;

          if (notifications.isEmpty) {
            return Center(
              child: Text(
                "No notifications yet",
                style: TextStyle(fontSize: 20.sp, color: Colors.black),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: notifications.length,
            separatorBuilder: (_, __) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              final message = notifications[index];
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.notifications_active,
                      color: ColorsManager.orange,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Engzly Notification",
                            style: AppFonts.font14BWhiteWeight700.copyWith(
                              color: ColorsManager.black,
                              fontSize: 16.sp,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            message,
                            style: AppFonts.font13BlackWeight500.copyWith(
                              color: Colors.grey[700],
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
