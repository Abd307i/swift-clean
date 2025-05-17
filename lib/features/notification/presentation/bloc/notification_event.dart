import 'package:equatable/equatable.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class GetNotificationsEvent extends NotificationEvent {
  final String userId;

  const GetNotificationsEvent(this.userId);

  @override
  List<Object> get props => [userId];
}

class MarkNotificationAsReadEvent extends NotificationEvent {
  final String notificationId;

  const MarkNotificationAsReadEvent(this.notificationId);

  @override
  List<Object> get props => [notificationId];
}

class ToggleNotificationMuteEvent extends NotificationEvent {
  final bool isMuted;

  const ToggleNotificationMuteEvent(this.isMuted);

  @override
  List<Object> get props => [isMuted];
}