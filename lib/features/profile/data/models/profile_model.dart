import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testing_firebase/features/profile/domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity{
  const ProfileModel({
    required super.userId,
    required super.firstName,
    required super.lastName,
    required super.phone,
    super.imgUrl,
    super.address
});

  ProfileModel copyWith({
    String? userId,
    String? firstName,
    String? lastName,
    String? phone,
    String? imgUrl,
    String? address,
}){
    return ProfileModel(
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      imgUrl: imgUrl ?? this.imgUrl,
      address: address ?? this.address
    );
  }

  factory ProfileModel.fromJson(Map<String,dynamic> json){
    return ProfileModel(
      userId: json['userId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phone: json['phone'],
      imgUrl: json['imgUrl'],
      address: json['address']
    );
  }

  factory ProfileModel.fromEntity(ProfileEntity entity){
    return ProfileModel(
      userId: entity.userId,
      firstName: entity.firstName,
      lastName: entity.lastName,
      phone: entity.phone,
      imgUrl: entity.imgUrl,
      address: entity.address
    );
  }



  Map<String, dynamic> toJson() => {
    'userId':userId,
    'firstName':firstName,
    'lastName':lastName,
    'phone':phone,
    'imageUrl':imgUrl,
    'address':address
  };

}