// Purpose: This file defines the NotificationDataSource class, which handles interactions with Firebase services (Firestore and Firebase Cloud Messaging).
// It manages creating, fetching, and updating notifications, sending push notifications via FCM, finding nearby drivers using geoflutterfire2,
// and updating order statuses. Ensure cloud_firestore: ^4.17.5, firebase_messaging: ^15.0.0, and geoflutterfire2: ^2.3.15 are in pubspec.yaml.
// Firebase must be initialized, and FCM permissions must be requested.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:testing_firebase/features/notification/data/models/notification_model.dart';
import 'package:testing_firebase/features/notification/domain/entities/notification_entity.dart';
//import 'package:geoflutterfire2/geoflutterfire2.dart';
//import 'package:geoflutterfire/geoflutterfire.dart';

class NotificationDataSource {
  final FirebaseFirestore _firestore;
  //final GeoFlutterFire _geo = GeoFlutterFire(); // geoflutterfire2 for geolocation queries
 //final FirebaseMessaging _messaging; // FirebaseMessaging for push notifications

  NotificationDataSource(this._firestore);
/*
  // Creates a new notification in Firestore and sends a push notification.
  Future<void> createNotification(NotificationModel notification) async {
    try {
      final docRef = await _firestore.collection('Notifications').add(notification.toJson());
      // Pass the generated ID to the notification for push notification
      await _sendPushNotification(notification.copyWith());
    } catch (e) {
      throw Exception('Error creating notification: $e');
    }
  }

  // Fetches notifications for a specific customer or shop, sorted by creation time.
  Future<List<NotificationEntity>> fetchNotifications({
    String? customerId,
    String? shopId,
  }) async {
    try {
      Query<Map<String, dynamic>> query = _firestore.collection('Notifications');
      if (customerId != null) {
        query = query.where('customerId', isEqualTo: customerId);
      } else if (shopId != null) {
        query = query.where('shopId', isEqualTo: shopId);
      }
      final snapshot = await query.orderBy('createdAt', descending: true).get();
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id; // Add document ID to the data
        return NotificationModel.fromJson(data).toEntity();
      }).toList();
    } catch (e) {
      throw Exception('Error fetching notifications: $e');
    }
  }

  // Updates a notification's read status to true.
  Future<void> updateNotificationReadStatus(String notificationId) async {
    try {
      await _firestore.collection('Notifications').doc(notificationId).update({
        'read': true,
      });
    } catch (e) {
      throw Exception('Error updating notification read status: $e');
    }
  }

  // Finds nearby drivers within a specified radius from a shop's location.
  // Uses geoflutterfire2 to query Users with a 'location' GeoPoint field.
  /*Future<List<String>> getNearbyDrivers(GeoPoint shopLocation, double radiusInKm) async {
    try {
      final center = _geo.point(
        latitude: shopLocation.latitude,
        longitude: shopLocation.longitude,
      );
      // Query users with a 'location' field within the radius
      final stream = _geo
          .collection(collectionRef: _firestore.collection('Users'))
          .within(center: center, radius: radiusInKm, field: 'location');
      final users = await stream.first;
      return users
          .where((doc) => doc.data()['userType'] == 'driver') // Filter for drivers
          .map((doc) => doc.id)
          .toList();
    } catch (e) {
      throw Exception('Error finding nearby drivers: $e');
    }
  }*/

  // Updates the status of an order in Firestore.
  Future<void> setOrderStatus(String orderId, String status) async {
    try {
      await _firestore.collection('Orders').doc(orderId).update({
        'status': status,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Error updating order status: $e');
    }
  }

  // Sends a push notification via FCM to the recipient (customer or shop owner).
  // Retrieves fcmToken from Users collection and logs the notification (placeholder).
  Future<void> _sendPushNotification(NotificationModel notification) async {
    try {
      String? fcmToken;
      if (notification.customerId != null) {
        final userDoc = await _firestore.collection('Users').doc(notification.customerId).get();
        fcmToken = userDoc.data()?['fcmToken'] as String?;
      } else if (notification.shopId != null) {
        final shopDoc = await _firestore.collection('Shops').doc(notification.shopId).get();
        final ownerId = shopDoc.data()?['ownerID'] as String?;
        if (ownerId != null) {
          final userDoc = await _firestore.collection('Users').doc(ownerId).get();
          fcmToken = userDoc.data()?['fcmToken'] as String?;
        }
      }

      if (fcmToken != null) {
        // Placeholder for FCM push notification (requires server-side implementation).
        print('Sending push notification to $fcmToken: ${notification.title} - ${notification.body}');
      }
    } catch (e) {
      throw Exception('Error sending push notification: $e');
    }
  }
 */

  Future<List<NotificationEntity>> getNotifications(String userId) async{
    try{
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('notifications')
          //.orderBy('timestamp', descending: true)
          .get();
      print(snapshot.docs.map((doc) => NotificationModel.fromJson(doc.data())).toList());
      return snapshot.docs.map((doc) => NotificationModel.fromJson(doc.data())).toList();
    } catch (e){
      print(e.toString());
      throw e.toString();
    }
  }

}