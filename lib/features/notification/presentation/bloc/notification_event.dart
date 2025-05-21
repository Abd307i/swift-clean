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

class GetStreamNotificationsEvent extends NotificationEvent{
  final String userId;
  const GetStreamNotificationsEvent(this.userId);
  // May be error
  @override
  List<Object> get props => [userId];
}

class ConsumeError extends NotificationEvent{
  const ConsumeError();
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