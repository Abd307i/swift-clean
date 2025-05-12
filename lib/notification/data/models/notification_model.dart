// Purpose: This file defines the NotificationModel class, which represents the data structure for a notification.
// It provides methods to serialize (toJson) and deserialize (fromJson) notification data to/from Firestore.
// The model matches the Notifications collection schema in Firestore.

import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String? id;
  final String body;
  final Timestamp createdAt;
  final String? customerId;
  final String? orderId;
  final bool read;
  final String? shopId;
  final String title;
  final String type;

  NotificationModel({
    this.id,
    required this.body,
    required this.createdAt,
    this.customerId,
    this.orderId,
    required this.read,
    this.shopId,
    required this.title,
    required this.type,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String?,
      body: json['body'] as String,
      createdAt: json['createdAt'] as Timestamp,
      customerId: json['customerId'] as String?,
      orderId: json['orderId'] as String?,
      read: json['read'] as bool,
      shopId: json['shopId'] as String?,
      title: json['title'] as String,
      type: json['type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'body': body,
      'createdAt': createdAt,
      'customerId': customerId,
      'orderId': orderId,
      'read': read,
      'shopId': shopId,
      'title': title,
      'type': type,
    };
  }

  NotificationModel copyWith({
    String? id,
    String? body,
    Timestamp? createdAt,
    String? customerId,
    String? orderId,
    bool? read,
    String? shopId,
    String? title,
    String? type,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
      customerId: customerId ?? this.customerId,
      orderId: orderId ?? this.orderId,
      read: read ?? this.read,
      shopId: shopId ?? this.shopId,
      title: title ?? this.title,
      type: type ?? this.type,
    );
  }
}