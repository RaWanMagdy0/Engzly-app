import 'package:engzly/core/routing/app_router.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/routing/route_name.dart';
import 'core/theming/app_theme.dart';

class EngzlyApp extends StatelessWidget {
  final bool isFirstTime;
  final bool rememberMe;

  const EngzlyApp({
    super.key,
    required this.isFirstTime,
    required this.rememberMe,
  });

  @override
  Widget build(BuildContext context) {
    String initialRoute;

    if (isFirstTime) {
      initialRoute = RouteName.onBoarding;
    } else if (rememberMe) {
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
          theme: AppTheme.appTheme.copyWith(
            textTheme: GoogleFonts.dmSansTextTheme(
              AppTheme.appTheme.textTheme,
            ),
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              centerTitle: true,
              elevation: 0,
              titleTextStyle: AppFonts.font20BlackWeight700.copyWith(
                fontSize: 18.sp,
                color: Colors.black,
              ),
              iconTheme: const IconThemeData(color: Colors.black),
              actionsIconTheme: const IconThemeData(color: Colors.black),
            ),
          ),

          initialRoute: initialRoute,
          onGenerateRoute: AppRouter.generateRoute,
        );
      },
    );
  }
}
