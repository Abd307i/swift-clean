import 'package:firebase_auth/firebase_auth.dart';
import 'package:testing_firebase/auth/domain/entites/user_entity.dart';

import 'address_model.dart';


class UserModel extends UserEntity{
  const UserModel({
    required super.id,
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.phone,
    super.address,
    required super.emailVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
        id: json['id'],
        email: json['email'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        phone:json['phone'],
        address: json['address'],
        emailVerified: json['emailVerified']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id':id,
      'email':email,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'address': address,
      'emailVerified': emailVerified
    };
  }
  factory UserModel.fromFirebaseUser(User user, {Map<String, dynamic>? data}) {
    return UserModel(
      id: user.uid,
      email: user.email ?? '',
      firstName: data?['firstName'] ?? '',
      lastName: data?['lastName'] ?? '',
      phone: data?['phone'] ?? '',
      address: data?['address'] != null
          ? AddressModel.fromJson(data!['address'])
          : const AddressModel( // Default empty address
        street: '',
        city: '',
        postalCode: '',
        lat: 0,
        lng: 0,
      ),
      emailVerified: user.emailVerified,
    );
  }
}