import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'notification_state.dart';

@LazySingleton()
class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial()) {
    _loadNotifications();
  }

  final List<String> _notifications = [];
  bool hasUnread = false;
  List<String> get notifications => List.unmodifiable(_notifications);

  Future<void> _loadNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList('notifications') ?? [];
    hasUnread = prefs.getBool('hasUnread') ?? false;
    _notifications.addAll(saved);
    if (_notifications.isNotEmpty) {
      emit(NotificationReceived(List.from(_notifications)));
    }
  }

  Future<void> addNotification(String message) async {
    _notifications.insert(0, message);
    hasUnread = true;
    emit(NotificationReceived(List.from(_notifications)));

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('notifications', _notifications);
    await prefs.setBool('hasUnread', true);
  }

  Future<void> clearNotifications() async {
    _notifications.clear();
    hasUnread = false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('notifications');
    await prefs.setBool('hasUnread', false);
    emit(NotificationInitial());
  }

  Future<void> markAllAsRead() async {
    hasUnread = false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasUnread', false);
    emit(NotificationReceived(List.from(_notifications)));
  }
}
