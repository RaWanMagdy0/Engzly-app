import 'package:engzly/core/di/di.dart';
import 'package:engzly/features/history/history.dart';
import 'package:engzly/features/home/ui/home_screen.dart';
import 'package:engzly/features/offers/offers.dart';
import 'package:engzly/features/profile/logic/cubit.dart';
import 'package:engzly/features/profile/ui/main_profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';
import 'widgets/motion_tab_bar_widget.dart';

class HomeLayoutScreen extends StatefulWidget {
  const HomeLayoutScreen({super.key});

  @override
  State<HomeLayoutScreen> createState() => _HomeLayoutScreenState();
}

class _HomeLayoutScreenState extends State<HomeLayoutScreen>
    with TickerProviderStateMixin {
  late MotionTabBarController _motionTabBarController;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _motionTabBarController = MotionTabBarController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
    _motionTabBarController.addListener(() {
      setState(() {});
    });
    _screens = [
      HomeScreen(),
      HistoryScreen(),
      OffersScreen(),
      BlocProvider(
        create: (context) => getIt<ProfileCubit>(),
        child: ProfileScreen(),
      ),
    ];
  }

  @override
  void dispose() {
    _motionTabBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _motionTabBarController.index,
        children: _screens,
      ),
      bottomNavigationBar: MotionTabBarWidget(
        controller: _motionTabBarController,
      ),
    );
  }
}
