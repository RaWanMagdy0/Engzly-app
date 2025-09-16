import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({super.key});

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  bool pushNotification = true;
  bool promoNotification = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "NOTIFICATIONS",
            style: AppFonts.font14BOrangeWeight400.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 10.h),
          Column(
            children: [
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                secondary: const Icon(
                  Icons.notifications_none,
                  color: Colors.black54,
                ),
                title: const Text(
                  "Push Notifications",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: const Text("For daily update and others."),
                value: pushNotification,
                activeThumbColor: ColorsManager.white,
                activeTrackColor: ColorsManager.orange,
                onChanged: (val) {
                  setState(() {
                    pushNotification = val;
                  });
                },
              ),
              const Divider(),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                secondary: const Icon(
                  Icons.notifications_none,
                  color: Colors.black54,
                ),
                title: const Text(
                  "Promotional Notifications",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: const Text("New Campaign & Offers"),
                value: promoNotification,
                activeThumbColor: ColorsManager.white,
                activeTrackColor: ColorsManager.orange,
                onChanged: (val) {
                  setState(() {
                    promoNotification = val;
                  });
                },
              ),
              const Divider(),
            ],
          ),
        ],
      ),
    );
  }
}
