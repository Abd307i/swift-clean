import '../entities/notification_entity.dart';

abstract class NotificationRepository {
  // Fetch notifications
  Future<List<NotificationEntity>> getNotifications(String userId);

  Stream<List<NotificationEntity>> getStreamNotificaiotns(String userId);
  // Toggle global mute
  //Future<void> toggleMuteNotifications(bool isMuted);

  // Mark as read
 // Future<void> markAsRead(String notificationId);
}