import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfoModel {
  final String userId;
  final String firstName;
  final String lastName;
  final String phone;
  final String address;
  final String? email; //from firebase auth
  final Timestamp? createdAt; //automatically set to current time

  UserInfoModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.address,
    this.email,
    this.createdAt,
  });

  // Convert model to Firestore JSON
  Map<String, dynamic> toJson() => {
        'userId': userId,
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'address': address,
        if (email != null) 'email': email,
        if (createdAt != null) 'createdAt': createdAt,
      };

  // Create model from Firestore JSON
  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      userId: json['userId'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      email: json['email'] as String?,
      createdAt: json['createdAt'] as Timestamp?,
    );
  }
}