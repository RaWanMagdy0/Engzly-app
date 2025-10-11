import 'package:engzly/core/routing/app_router.dart';
import 'package:engzly/core/theming/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'core/routing/route_name.dart';

class EngzlyApp extends StatelessWidget {
  final bool isFirstTime;
  final String? token;
  final bool rememberMe;

  const EngzlyApp({
    super.key,
    required this.isFirstTime,
    required this.token,
    required this.rememberMe,
  });

  @override
  Widget build(BuildContext context) {

    String initialRoute;

    if (isFirstTime) {
      initialRoute = RouteName.onBoarding;
    } else if (token != null && token!.isNotEmpty && rememberMe) {
      initialRoute = RouteName.homeLayout;
    } else {
      initialRoute = RouteName.login;
    }

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Engzly',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.appTheme,
          initialRoute: initialRoute,
          onGenerateRoute: AppRouter.generateRoute,
        );
      },
    );
  }
}
