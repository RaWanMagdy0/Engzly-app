import 'package:engzly/core/shared_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A reusable Scaffold layout with a custom AppBar and a white container for the main content.

class CustomScaffoldScreen extends StatelessWidget {
  final Widget title; // Widget shown in the AppBar center (Text, Row, ..)
  final String leadingIcon; // Path of the left icon (back arrow/category)
  final String notificationIcon;
  final VoidCallback? onLeadingTap;
  final VoidCallback? onNotificationTap;
  final bool showNotificationDot;
  final Widget child; // Main content of the screen inside the white container

  const CustomScaffoldScreen({
    super.key,
    required this.title,
    required this.child,
    required this.leadingIcon,
    required this.notificationIcon,
    this.onLeadingTap,
    this.onNotificationTap,
    this.showNotificationDot = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        title: title, // Pass title widget to AppBar
        leadingIcon: leadingIcon,
        notificationIcon: notificationIcon,
        onLeadingTap: onLeadingTap,
        onNotificationTap: onNotificationTap,
        showNotificationDot: showNotificationDot, // Show or hide red dot
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.r),
            topRight: Radius.circular(40.r),
          ),
        ),
        child: child, // Place the screen content here
      ),
    );
  }
}
