import 'package:engzly/core/di/di.dart' show getIt;
import 'package:engzly/core/routing/route_name.dart';
import 'package:engzly/features/auth/logic/login_cubit/cubit.dart';
import 'package:engzly/features/auth/logic/register_cubit/cubit.dart';
import 'package:engzly/features/auth/ui/forgot_password/email_verification_screen.dart';
import 'package:engzly/features/auth/ui/forgot_password/forget_password_screen.dart';
import 'package:engzly/features/auth/ui/forgot_password/reset_password_screen.dart';
import 'package:engzly/features/auth/ui/login/login_screen.dart';
import 'package:engzly/features/auth/ui/sign_up/widgets/email_confirmation.dart';
import 'package:engzly/features/auth/ui/sign_up/sign_up_page.dart';
import 'package:engzly/features/home_layout/home_layout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/onBoarding/onboarding_screen.dart';

class AppRouter {
  static Route? generateRoute(RouteSettings settings) {
    //  final arguments = settings.arguments;
    switch (settings.name) {
      //----------- OnboardingScreen Screens -----------
      case RouteName.onBoarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      //----------- login Screen -----------
      case RouteName.login:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: LogInScreen(),
          ),
        );

      case RouteName.signUp:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<RegisterCubit>(),
            child: SignUpPage(),
          ),
        );
      case RouteName.emailConfirmation:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<RegisterCubit>(),
            child: EmailConfirmation(),
          ),
        );

      case RouteName.forgetPassword:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());
      case RouteName.emailVerification:
        return MaterialPageRoute(
            builder: (_) => const EmailVerificationScreen());
      case RouteName.resetPassword:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());

      case RouteName.homeLayout:
        return MaterialPageRoute(builder: (_) => const HomeLayoutScreen());

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

  /**********
 *   static PageRouteBuilder _createPageTransition({
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
 */
}

enum PageTransitionType { slide, fade, scale }
