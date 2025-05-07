import '../entities/notification_entity.dart';

abstract class NotificationRepository {
  // Fetch notifications
  Future<List<NotificationEntity>> getNotifications(String userId);

  // Toggle global mute
  Future<void> toggleMuteNotifications(bool isMuted);

  // Mark as read
  Future<void> markAsRead(String notificationId);
}