import 'package:flutter/material.dart';

class AppRouter {
  static Route? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      //----------- Auth Screens -----------
      // case Routes.loginScreen:
      //   return _createPageTransition(
      //     child: BlocProvider<LoginCubit>(
      //       create: (context) => getIt<LoginCubit>(),
      //       child: const LoginScreen(),
      //     ),
      //     transitionType: PageTransitionType.fade,
      //   );

      default:
        return null;
    }
  }

  static PageRouteBuilder _createPageTransition({
    required Widget child,
    PageTransitionType transitionType = PageTransitionType.slide,
  }) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.easeInOut;

        if (transitionType == PageTransitionType.slide) {
          final slideTween = Tween(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).chain(CurveTween(curve: curve));
          final slideAnimation = animation.drive(slideTween);
          return SlideTransition(position: slideAnimation, child: child);
        }

        if (transitionType == PageTransitionType.fade) {
          return FadeTransition(opacity: animation, child: child);
        }

        if (transitionType == PageTransitionType.scale) {
          return ScaleTransition(scale: animation, child: child);
        }

        return child;
      },
    );
  }
}

enum PageTransitionType { slide, fade, scale }
