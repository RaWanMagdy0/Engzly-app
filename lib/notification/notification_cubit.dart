import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'notification_state.dart';

@injectable
class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  final List<String> _notifications = [];

  List<String> get notifications => List.unmodifiable(_notifications);

  void addNotification(String message) {
    _notifications.insert(0, message);
    emit(NotificationReceived(List.from(_notifications)));
  }

  void clearNotifications() {
    _notifications.clear();
    emit(NotificationInitial());
  }
}
