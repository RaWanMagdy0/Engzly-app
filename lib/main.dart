import 'package:engzly/engzly_app.dart';
import 'package:engzly/core/bloc/bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  // Set up the BlocObserver for debugging
  Bloc.observer = AppBlocObserver();

  runApp(const EngzlyApp());
}
