import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:engzly/core/bloc/bloc_observer.dart';
import 'package:engzly/core/di/di.dart';
import 'package:engzly/core/helper/local/secure_storage.dart';
import 'package:engzly/engzly_app.dart';
import 'package:engzly/notification/notficatio_service.dart';
import 'package:engzly/notification/notification_cubit.dart';
import 'package:engzly/notification/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _requestNotificationPermission() async {
  final androidImplementation =
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
  await androidImplementation?.requestNotificationsPermission();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Firebase initialization
    await Firebase.initializeApp();

    // Notification setup
    await NotificationHelper.init();
    await _requestNotificationPermission();
    Bloc.observer = AppBlocObserver();
    configureDependencies();

    // Stripe configuration
    Stripe.publishableKey =
        'pk_test_51SA7jDA6rtRTWn7mEnguFl9Mzp7e98QsoHTkvcbYbMexDrcG5YM7yfhaCjDOFhyY5MY9Lw6CP1pfQXsU1pGQNBN200kUhoYNrt';
    await Stripe.instance.applySettings();

    // SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    // Secure storage
    final String? rememberMeValue =
        await SecureStorageFactory.readData(key: 'rememberMe');
    final bool rememberMe = (rememberMeValue ?? 'false') == 'true';

    // SignalR service
    final signalRService = getIt<SignalRService>();

    signalRService.onNotificationReceived = (message) async {
      debugPrint(" Notification received: $message");

      final cubit = getIt<NotificationCubit>();
      cubit.addNotification(message);

      await NotificationHelper.showNotification(
        title: "Engzly",
        body: message,
      );
    };

    // Connect to SignalR
    await signalRService.initConnection();

    FlutterNativeSplash.remove();

    // Run app
    runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: getIt<NotificationCubit>(),
          ),
        ],
        child: EngzlyApp(
          isFirstTime: isFirstTime,
          rememberMe: rememberMe,
        ),
      ),
    );
  } catch (e, stackTrace) {
    debugPrint(" Error during app initialization: $e");
    debugPrint("Stack trace: $stackTrace");

    FlutterNativeSplash.remove();

    final prefs = await SharedPreferences.getInstance();
    final bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
    final String? rememberMeValue =
        await SecureStorageFactory.readData(key: 'rememberMe');
    final bool rememberMe = (rememberMeValue ?? 'false') == 'true';

    runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: getIt<NotificationCubit>(),
          ),
        ],
        child: EngzlyApp(
          isFirstTime: isFirstTime,
          rememberMe: rememberMe,
        ),
      ),
    );
  }
}
