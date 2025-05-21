import 'package:equatable/equatable.dart';
import 'package:testing_firebase/features/notification/domain/entities/notification_entity.dart';

class UniNotificationState extends Equatable{

  final List<NotificationEntity>? notifications;
  final String? error;
  final bool? isLoading;



  UniNotificationState({
    this.notifications,
    this.error,
    this.isLoading
  });


  UniNotificationState copy(
  {
    List<NotificationEntity>? notifications,
    String? error,
    bool? isLoading
}
      ){

    return UniNotificationState(
      notifications: notifications ?? this.notifications,
      error: error?? this.error,
      isLoading: isLoading ?? this.isLoading
    );



  }

  UniNotificationState copyWithNewNotification(List<NotificationEntity> notification){
    List<NotificationEntity> list;
    if(this.notifications == null){
      list = notification;
    }else{
      list= notification+notifications!;

    }
    return copy(
        notifications: list,
      error: '',
      isLoading: false
    );
  }

  @override
  List<Object?> get props => [notifications, error, isLoading];
}