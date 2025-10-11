import 'package:engzly/core/theming/colors.dart';
import 'package:engzly/core/theming/fonts.dart';
import 'package:engzly/core/shared_widgets/custom_botton.dart';
import 'package:engzly/features/onBoarding/widgets/indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/routing/route_name.dart';
import '../../../core/theming/images.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0;

  final List<Map<String, String>> pages = [
    {
      'image': AppImages.onBoarding1,
      'mainText': 'Easy Process',
      'caption':
          'Find all your house needs in one place. We provide every service to make your home experience smooth.',
    },
    {
      'image': AppImages.onBoarding2,
      'mainText': 'Fast Transportations',
      'caption':
          "We provide the best transportation service and organize your furniture properly to prevent any damage.",
    },
    {
      'image': AppImages.onBoarding3,
      'mainText': 'Expert People',
      'caption':
          "We have the best in class individuals working just for you. They are well trained and capable of handling anything you need.",
    },
  ];

  Future<void> _finishOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);
    Navigator.pushReplacementNamed(context, RouteName.login);
  }

  void _nextPage() {
    if (_currentPage < pages.length - 1) {
      setState(() => _currentPage++);
    } else {
      _finishOnboarding();
    }
  }

  void _skipOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);
    Navigator.pushReplacementNamed(context, RouteName.login);
  }

  @override
  Widget build(BuildContext context) {
    final currentData = pages[_currentPage];

    return Scaffold(
      body: Column(
        children: [
          AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              transitionBuilder: (child, animation) => ScaleTransition(
                    scale: animation,
                    child: child,
                  ),
              child: Stack(
                children: [
                  Image.asset(
                    currentData['image']!,
                    key: ValueKey<String>(currentData['image']!),
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 45.h,
                    right: 32.w,
                    child: GestureDetector(
                      onTap: _skipOnboarding,
                      child: Container(
                          width: 60, height: 35, color: Colors.transparent),
                    ),
                  ),
                ],
              )),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (child, animation) => SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(-1, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: FadeTransition(opacity: animation, child: child),
                  ),
                  child: Text(
                    currentData['mainText']!,
                    key: ValueKey<String>(currentData['mainText']!),
                    style: AppFonts.font36BlackWeight700,
                    textAlign: TextAlign.center,
                  ),
                ),
                16.verticalSpace,
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (child, animation) => SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: FadeTransition(opacity: animation, child: child),
                  ),
                  child: Padding(
                    key: ValueKey<String>(currentData['caption']!),
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Text(
                      currentData['caption']!,
                      style: AppFonts.font16BlackWeight400.copyWith(
                        color: Colors.black.withValues(alpha: 0.5),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Indicator(
                  pageController: PageController(initialPage: _currentPage),
                  pagesCount: pages.length,
                ),
                20.verticalSpace,
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (child, animation) => SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 1),
                      end: Offset.zero,
                    ).animate(animation),
                    child: FadeTransition(opacity: animation, child: child),
                  ),
                  child: CustomButton(
                    key: ValueKey<int>(_currentPage),
                    onPressed: _nextPage,
                    width: 290.w,
                    height: 55.h,
                    borderRadius: 16.r,
                    text: _currentPage == pages.length - 1
                        ? "Get Started"
                        : "Next",
                    textStyle: AppFonts.font14BWhiteWeight700,
                    backgroundColor: ColorsManager.orange,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
