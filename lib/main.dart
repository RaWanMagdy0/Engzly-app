import 'package:engzly/core/bloc/bloc_observer.dart';
import 'package:engzly/core/di/di.dart';
import 'package:engzly/core/helper/local/secure_storage.dart';
import 'package:engzly/engzly_app.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();

  configureDependencies();

  final prefs = await SharedPreferences.getInstance();
  final bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
  final String? token = await SecureStorageFactory.readData(key: 'token');

  runApp(EngzlyApp(
    isFirstTime: isFirstTime,
    token: token,
  ));

  FlutterNativeSplash.remove();
}
