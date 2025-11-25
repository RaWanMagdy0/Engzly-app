import 'package:engzly/core/di/di.dart' show getIt;
import 'package:engzly/core/routing/route_name.dart';
import 'package:engzly/features/auth/logic/forget_password/forget_pass_cubit/cubit.dart';
import 'package:engzly/features/auth/logic/forget_password/reset_pass_cubit/cubit.dart';
import 'package:engzly/features/auth/logic/forget_password/verify_email/cubit.dart';
import 'package:engzly/features/auth/logic/login_cubit/login/cubit.dart';
import 'package:engzly/features/auth/logic/login_cubit/google.dart/google_cubit.dart';
import 'package:engzly/features/auth/logic/register_cubit/cubit.dart';
import 'package:engzly/features/auth/ui/forgot_password/email_verification_screen.dart';
import 'package:engzly/features/auth/ui/forgot_password/forget_password_screen.dart';
import 'package:engzly/features/auth/ui/forgot_password/reset_password_screen.dart';
import 'package:engzly/features/auth/ui/login/login/login_screen.dart';
import 'package:engzly/features/auth/ui/sign_up/widgets/email_confirmation.dart';
import 'package:engzly/features/auth/ui/sign_up/sign_up_page.dart';
import 'package:engzly/features/home/logic/cubit.dart';
import 'package:engzly/features/home/ui/home_screen.dart';
import 'package:engzly/features/home_layout/home_layout_screen.dart';
import 'package:engzly/features/offers/ui/logic/offers_cubit.dart';
import 'package:engzly/features/offers/ui/ui/offers.dart';
import 'package:engzly/features/profile/logic/cubit.dart';
import 'package:engzly/features/profile/ui/change_password/change_password_screen.dart';
import 'package:engzly/features/profile/ui/contact_us/contact_us_screen.dart';
import 'package:engzly/features/profile/ui/contact_us/questions_screen.dart';
import 'package:engzly/features/profile/ui/edit_profile_screen/edit_profile_screen.dart';
import 'package:engzly/features/profile/ui/location/add_location/add_location_screen.dart';
import 'package:engzly/features/profile/ui/location/my_location/my_location.dart'
    show MyLocation;
import 'package:engzly/features/profile/ui/main_profile_screen/profile_screen.dart';
import 'package:engzly/features/services/cleaning/logic/cleaning_cubit.dart';
import 'package:engzly/features/services/cleaning/ui/cleaning/first_screen/cleaning_screen.dart';
import 'package:engzly/features/services/cleaning/ui/cleaning/order_details/cleaning_order_details.dart';
import 'package:engzly/features/services/cleaning/ui/cleaning/second_screen/cleaning_schedule_screen.dart';
import 'package:engzly/features/services/cleaning/ui/cleaning/third_screen/cleaning_choose_location.dart';
import 'package:engzly/features/services/house_shifting/logic/booking_cubit.dart';
import 'package:engzly/features/services/house_shifting/logic/cubit.dart';
import 'package:engzly/features/services/house_shifting/ui/house_shifting_service/first_screen/house_shifting_screen.dart';
import 'package:engzly/features/services/house_shifting/ui/house_shifting_service/house_shiffting_order_confirmation.dart';
import 'package:engzly/features/services/house_shifting/ui/house_shifting_service/order_details/order_details.dart';
import 'package:engzly/features/services/house_shifting/ui/house_shifting_service/second_screen/schedule_screen.dart';
import 'package:engzly/features/services/house_shifting/ui/house_shifting_service/third_screen/choose_location.dart';
import 'package:engzly/features/services/painting/logic/painting_cubit.dart';
import 'package:engzly/features/services/painting/ui/painting/first_screen/painting_screen.dart';
import 'package:engzly/features/services/painting/ui/painting/painting_order_confirmation.dart'
    show PaintingOrderConfirmation;
import 'package:engzly/features/services/vehicle/logic/vehicle_cubit.dart';
import 'package:engzly/features/services/vehicle/ui/vehicle/first_screen/vehicle_screen.dart';
import 'package:engzly/features/services/vehicle/ui/vehicle/vehicle_order_confirmation.dart';
import 'package:engzly/notification/nitification_screen.dart';
import 'package:engzly/notification/notification_cubit.dart';
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
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<GoogleLoginCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<LoginCubit>(),
              ),
            ],
            child: const LogInScreen(),
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
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<ForgetPasswordCubit>(),
            child: ForgetPasswordScreen(),
          ),
        );
      case RouteName.emailVerification:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<VerifyEmailCubit>(),
            child: EmailVerificationScreen(),
          ),
        );

      case RouteName.resetPassword:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<ResetPasswordCubit>(),
            child: ResetPasswordScreen(),
          ),
        );

      //----------- Main Screen -----------

      case RouteName.homeLayout:
        return MaterialPageRoute(builder: (_) => const HomeLayoutScreen());

      case RouteName.homeScreen:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<HomeCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<HouseShiftingBookingCubit>(),
              ),
              BlocProvider(create: (context) => getIt<CleaningCubit>()),
              BlocProvider(create: (context) => getIt<VehicleCubit>()),
              BlocProvider(create: (context) => getIt<PaintingCubit>()),
            ],
            child: const HomeScreen(),
          ),
        );
      case RouteName.offers:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<OffersCubit>(),
              ),
            ],
            child: const OffersScreen(),
          ),
        );

      //----------- profile Screens -----------

      case RouteName.profile:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<ProfileCubit>(),
            child: ProfileScreen(),
          ),
        );
      case RouteName.editProfile:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<ProfileCubit>(),
            child: EditProfileScreen(),
          ),
        );
      case RouteName.addLocation:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<ProfileCubit>(),
            child: AddLocationScreen(),
          ),
        );
      case RouteName.myLocation:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<ProfileCubit>()..getLocations(),
            child: MyLocation(),
          ),
        );
      case RouteName.changePassword:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<ProfileCubit>(),
            child: ChangePasswordScreen(),
          ),
        );
      case RouteName.contactUs:
        return MaterialPageRoute(builder: (_) => const ContactUsScreen());

      case RouteName.questions:
        return MaterialPageRoute(builder: (_) => const QuestionsScreen());

      case RouteName.houseShifting:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<HouseShiftingCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<HouseShiftingBookingCubit>(),
              ),
            ],
            child: const HouseShiftingScreen(),
          ),
        );
      case RouteName.scheduleScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<HouseShiftingCubit>(),
            child: ScheduleScreen(),
          ),
        );
      case RouteName.chooseLocation:
        return MaterialPageRoute(
            builder: (_) => const HouseChooseLocationScreen());

      case RouteName.orderDetails:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<HouseShiftingBookingCubit>(),
            child: OrderDetails(),
          ),
        );
      case RouteName.orderConfirmation:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<ProfileCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<HouseShiftingBookingCubit>(),
              ),
            ],
            child: const HouseShifftingOrderConfirmation(),
          ),
        );

      case RouteName.cleaning:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<CleaningCubit>(),
              ),
            ],
            child: const CleaningScreen(),
          ),
        );
      case RouteName.cleaningSchedule:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<CleaningCubit>(),
              ),
            ],
            child: const CleaningScheduleScreen(),
          ),
        );
      case RouteName.cleaningLocation:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<CleaningCubit>(),
              ),
            ],
            child: const CleaningChooseLocation(),
          ),
        );
      case RouteName.cleaningOrderDetails:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<CleaningCubit>(),
              ),
            ],
            child: const CleaningOrderDetails(),
          ),
        );
/***************
 *       case RouteName.cleaningOrderConfirmation:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<CleaningCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<HouseShiftingBookingCubit>(),
              ),
            ],
            child: const CleaningOrderConfirmation(),
          ),
        );
 */
      case RouteName.vehicle:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<VehicleCubit>(),
              ),
            ],
            child: const VehicleScreen(),
          ),
        );
      case RouteName.vehicleOrderConfirmation:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<VehicleCubit>(),
              ),
            ],
            child: const VehicleOrderConfirmation(),
          ),
        );
      case RouteName.notification:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: getIt<NotificationCubit>(),
            child: const NotificationsScreen(),
          ),
        );

      case RouteName.painting:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<PaintingCubit>(),
              ),
            ],
            child: const PaintingScreen(),
          ),
        );
      case RouteName.paintingOrderConfirmation:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<PaintingCubit>(),
              ),
            ],
            child: const PaintingOrderConfirmation(),
          ),
        );

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
