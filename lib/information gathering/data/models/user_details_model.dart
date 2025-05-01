import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testing_firebase/information%20gathering/domain/entities/user_details_entity.dart';

class UserDetailsModel{
  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String? address;

  UserDetailsModel({required this.id, required this.firstName, required this.lastName, required this.phoneNumber, this.address});

  factory UserDetailsModel.fromFirestore(DocumentSnapshot doc){
    return UserDetailsModel(
      id: doc.id,
      firstName: doc['firstName'],
      lastName: doc['lastName'],
      phoneNumber: doc['phoneNumber'],
      address: doc['address']
    );
  }

  UserDetailsEntity toEntity() => UserDetailsEntity(id: id, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber);
}