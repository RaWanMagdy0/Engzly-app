import 'package:engzly/features/home/ui/home_screen.dart';
import 'package:flutter/material.dart';

class EngzlyApp extends StatelessWidget {
  const EngzlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen());
  }
}
