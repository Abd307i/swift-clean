import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_firebase/features/notification/domain/usecases/get_notifications.dart';
import 'package:testing_firebase/features/notification/domain/usecases/mark_as_read.dart';
import 'package:testing_firebase/features/notification/domain/usecases/toggle_mute_notifications.dart';
import 'package:testing_firebase/features/notification/presentation/bloc/notification_event.dart';
import 'package:testing_firebase/features/notification/presentation/bloc/notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetNotifications getNotifications;
  //final MarkAsRead markAsRead;
  // ToggleMuteNotification toggleMuteNotification;

  NotificationBloc({
    required this.getNotifications,
    //required this.markAsRead,
    //required this.toggleMuteNotification,
  }) : super(NotificationInitial()) {
    on<GetNotificationsEvent>(_onGetNotifications);
    //on<MarkNotificationAsReadEvent>(_onMarkNotificationAsRead);
    //on<ToggleNotificationMuteEvent>(_onToggleNotificationMute);
  }

  Future<void> _onGetNotifications(
      GetNotificationsEvent event,
      Emitter<NotificationState> emit,
      ) async {
    emit(NotificationLoading());
    try {
      final notifications = await getNotifications(event.userId);
      emit(NotificationLoaded(notifications));
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }
/*
  Future<void> _onMarkNotificationAsRead(
      MarkNotificationAsReadEvent event,
      Emitter<NotificationState> emit,
      ) async {
    try {
      await markAsRead(event.notificationId);
      emit(NotificationMarkedAsRead(event.notificationId));

      // Refresh notifications for the current user
      // We would need to keep track of the current user ID
      // For now, assuming we can get it from the current state
      if (state is NotificationLoaded) {
        final currentState = state as NotificationLoaded;
        // This is a simplification - in a real app, you would store the user ID
        // or retrieve it from a user repository/service
        if (currentState.notifications.isNotEmpty) {
          // Assuming all notifications belong to the same user
          final userId = currentState.notifications.first.id;
          add(GetNotificationsEvent(userId));
        }
      }
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }

  Future<void> _onToggleNotificationMute(
      ToggleNotificationMuteEvent event,
      Emitter<NotificationState> emit,
      ) async {
    try {
      await toggleMuteNotification(event.isMuted);
      emit(NotificationMuteToggled(event.isMuted));
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }*/
}