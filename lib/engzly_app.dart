import 'package:engzly/core/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/routing/route_name.dart';

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
          theme: ThemeData(
            textTheme: GoogleFonts.dmSansTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
          initialRoute: initialRoute,
          onGenerateRoute: AppRouter.generateRoute,
        );
      },
    );
  }
}
