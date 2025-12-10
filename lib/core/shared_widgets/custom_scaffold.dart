import 'package:engzly/core/routing/route_name.dart';
import 'package:engzly/core/shared_widgets/custom_app_bar.dart';
import 'package:engzly/core/shared_widgets/snackbar.dart';
import 'package:engzly/notification/notification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class CustomScaffoldScreen extends StatelessWidget {
  final Widget child;
  final Widget title;
  final Widget leadingIcon;
  final Widget notificationIcon;
  final VoidCallback? onLeadingTap;
  final VoidCallback? onNotificationTap;
  final bool clearSnackBarOnPop;

  const CustomScaffoldScreen({
    super.key,
    required this.title,
    required this.child,
    required this.leadingIcon,
    required this.notificationIcon,
    this.onLeadingTap,
    this.onNotificationTap,
    this.clearSnackBarOnPop = true,
  });

  @override
  Widget build(BuildContext context) {
    final notificationCubit = context.read<NotificationCubit>();

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (didPop && clearSnackBarOnPop) {
          SnackBarManager().clearSnackBars();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: title,
          leadingIcon: leadingIcon,
          notificationIcon: notificationIcon,
          onLeadingTap: onLeadingTap != null
              ? () {
                  if (clearSnackBarOnPop) {
                    SnackBarManager().clearSnackBars();
                  }
                  onLeadingTap!();
                }
              : null,
          onNotificationTap: () {
            notificationCubit.markAllAsRead();
            Navigator.pushNamed(context, RouteName.notification);
          },
        ),
        body: child,
      ),
    );
  }
}
