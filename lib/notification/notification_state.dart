part of 'notification_cubit.dart';


@immutable
sealed class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationReceived extends NotificationState {
  final List<String> notifications;
  NotificationReceived(this.notifications);
}
