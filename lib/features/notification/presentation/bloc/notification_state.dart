import 'package:equatable/equatable.dart';
import 'package:testing_firebase/features/notification/domain/entities/notification_entity.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class StreamNotificationsLoading extends NotificationState {}

class StreamNotificationsLoaded extends NotificationState{
  final Stream<List<NotificationEntity>> notifications;

  const StreamNotificationsLoaded(this.notifications);

  @override
  List<Object> get props => [notifications];
}

class NewNotificationArrived extends NotificationState {
  final NotificationEntity notifications;

  NewNotificationArrived(this.notifications);
}

class NotificationLoaded extends NotificationState {
  final List<NotificationEntity> notifications;

  const NotificationLoaded(this.notifications);

  @override
  List<Object> get props => [notifications];
}

class NotificationError extends NotificationState {
  final String message;

  const NotificationError(this.message);

  @override
  List<Object> get props => [message];
}

class NotificationMarkedAsRead extends NotificationState {
  final String notificationId;

  const NotificationMarkedAsRead(this.notificationId);

  @override
  List<Object> get props => [notificationId];
}

class NotificationMuteToggled extends NotificationState {
  final bool isMuted;

  const NotificationMuteToggled(this.isMuted);

  @override
  List<Object> get props => [isMuted];
}