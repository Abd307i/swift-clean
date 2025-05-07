// Purpose: This file implements the NotificationRepository interface, providing concrete logic for notification-related data operations.
// It delegates calls to the NotificationDataSource, acting as a bridge between the domain layer and the data layer.
// This maintains clean architecture by isolating Firebase-specific logic from the rest of the application.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testing_firebase/notification/data/datasources/remote/notification_remote_data_source.dart';
import 'package:testing_firebase/notification/data/models/notification_model.dart';
import 'package:testing_firebase/notification/domain/repositories/notification_repository.dart';

abstract class NotificationRepository {
  Future<void> createNotification(NotificationModel notification);
  Future<List<NotificationModel>> fetchNotifications({
    String? customerId,
    String? shopId,
  });
  Future<void> updateNotificationReadStatus(String notificationId);
  Future<List<String>> getNearbyDrivers(GeoPoint shopLocation, double radiusInKm);
  Future<void> setOrderStatus(String orderId, String status);
}

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationDataSource _dataSource;

  NotificationRepositoryImpl(this._dataSource);

  @override
  Future<void> createNotification(NotificationModel notification) async {
    await _dataSource.createNotification(notification);
  }

  @override
  Future<List<NotificationModel>> fetchNotifications({
    String? customerId,
    String? shopId,
  }) async {
    return await _dataSource.fetchNotifications(
      customerId: customerId,
      shopId: shopId,
    );
  }

  @override
  Future<void> updateNotificationReadStatus(String notificationId) async {
    await _dataSource.updateNotificationReadStatus(notificationId);
  }

  @override
  Future<List<String>> getNearbyDrivers(GeoPoint shopLocation, double radiusInKm) async {
    return await _dataSource.getNearbyDrivers(shopLocation, radiusInKm);
  }

  @override
  Future<void> setOrderStatus(String orderId, String status) async {
    await _dataSource.setOrderStatus(orderId, status);
  }
}