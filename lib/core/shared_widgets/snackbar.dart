import 'package:flutter/material.dart';

class SnackBarManager {
  static final SnackBarManager _instance = SnackBarManager._internal();
  factory SnackBarManager() => _instance;
  SnackBarManager._internal();

  ScaffoldMessengerState? _currentMessenger;

  void initialize(ScaffoldMessengerState messenger) {
    _currentMessenger = messenger;
  }

  void showSnackBar({
    required String message,
    Color? backgroundColor,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    hideCurrentSnackBar();

    _currentMessenger?.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: duration,
        action: action,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void showSuccessSnackBar(String message) {
    showSnackBar(
      message: message,
      backgroundColor: Colors.green,
    );
  }

  void showErrorSnackBar(String message) {
    showSnackBar(
      message: message,
      backgroundColor: Colors.red,
    );
  }

  void showInfoSnackBar(String message) {
    showSnackBar(
      message: message,
      backgroundColor: Colors.blue,
    );
  }

  void hideCurrentSnackBar() {
    _currentMessenger?.hideCurrentSnackBar();
  }

  void clearSnackBars() {
    _currentMessenger?.clearSnackBars();
  }
}