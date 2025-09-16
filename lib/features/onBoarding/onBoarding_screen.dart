import 'package:engzly/core/routing/route_name.dart';
import 'package:engzly/features/onBoarding/widgets/custom_onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theming/images.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> pages = [
    {
      'image': AppImages.onBoarding1,
      'mainText': 'Easy Process',
      'caption':
          '  Find all your house needs in one place. We provide every service to make your home experience smooth.',
    },
    {
      'image': AppImages.onBoarding2,
      'mainText': 'Fast Transportations',
      'caption':
          "We provide the best transportation service     and organize your furniture properly to   prevent any damage.",
    },
    {
      'image': AppImages.onBoarding3,
      'mainText': 'Expert People',
      'caption':
          "We have the best in class individuals working just for you. They are well trained and capable of handling anything you need.",
    },
  ];

  void _nextPage() {
    if (_currentPage < pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacementNamed(context, RouteName.login);
    }
  }

  void _skipOnboarding() {
    Navigator.pushReplacementNamed(context, RouteName.login);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: pages.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return CustomScreen(
                  onSkip: _skipOnboarding,
                  onNext: _nextPage,
                  isLastPage: _currentPage == pages.length - 1,
                  pageController: _pageController,
                  pagesCount: pages.length,
                  currentPage: _currentPage,
                  image: pages[index]['image']!,
                  mainText: pages[index]['mainText']!,
                  caption: pages[index]['caption']!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
