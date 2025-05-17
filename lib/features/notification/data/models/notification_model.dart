// Purpose: This file defines the NotificationModel class, which represents the data structure for a notification.
// It provides methods to serialize (toJson) and deserialize (fromJson) notification data to/from Firestore.
// The model matches the Notifications collection schema in Firestore.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testing_firebase/features/notification/domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required super.id,
    required super.title,
    required super.body,
    //required super.timestamp,
    required super.type,
    super.isRead = false
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ,
      title: json['title'] ,
      body: json['body'] ,
      //timestamp: (json['timestamp'] as Timestamp).toDate(),
      type: json['type'],
      isRead: json['isRead']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'body': body,
      //'timestamp': timestamp,
      'isRead': isRead,
      'title': title,
      'type': type,
    };
  }

}