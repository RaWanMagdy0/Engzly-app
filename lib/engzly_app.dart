import 'package:engzly/core/routing/app_router.dart';
import 'package:engzly/core/theming/app_theme.dart';
import 'package:engzly/features/home/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/routing/route_name.dart';

class EngzlyApp extends StatelessWidget {
  const EngzlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Engzly',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.appTheme,
          home: const HomeScreen(),
          initialRoute: RouteName.homeLayout,
          onGenerateRoute: AppRouter.generateRoute,
        );
      },
    );
  }
}
