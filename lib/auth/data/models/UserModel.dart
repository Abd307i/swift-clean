import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:testing_firebase/auth/domain/entites/user_entity.dart';

class UserModel extends UserEntity{
  const UserModel({
    required String id,
    required String email,
    required String firstName,
    required String lastName,
    required String phoneNumber
}) : super(id: id, email:email, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber);

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      id: json['id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phone'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id':id,
      'email':email,
      'firstName':firstName,
      'lastName':lastName,
      'phone': phoneNumber
    };
  }
  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      id: user.uid,
      email: user.email ?? '',
      firstName: user.displayName??'',
      lastName: user.displayName??'',
      phoneNumber: user.phoneNumber??''
    );
  }
}