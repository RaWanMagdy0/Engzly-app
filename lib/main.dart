import 'package:engzly/core/bloc/bloc_observer.dart';
import 'package:engzly/core/di/di.dart';
import 'package:engzly/core/helper/local/secure_storage.dart';
import 'package:engzly/engzly_app.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  Bloc.observer = AppBlocObserver();
  configureDependencies();

  Stripe.publishableKey =
      'pk_test_51SA7jDA6rtRTWn7mEnguFl9Mzp7e98QsoHTkvcbYbMexDrcG5YM7yfhaCjDOFhyY5MY9Lw6CP1pfQXsU1pGQNBN200kUhoYNrt';
  await Stripe.instance.applySettings();

  final prefs = await SharedPreferences.getInstance();
  final bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

  final String? rememberMeValue =
      await SecureStorageFactory.readData(key: 'rememberMe');
  final bool rememberMe = (rememberMeValue ?? 'false') == 'true';



  FlutterNativeSplash.remove();

  runApp(EngzlyApp(
    isFirstTime: isFirstTime,
    rememberMe: rememberMe,
  ));
}

