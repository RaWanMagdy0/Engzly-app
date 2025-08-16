import 'package:engzly/features/home/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
          home: const HomeScreen(),
        );
      },
    );
  }
}
