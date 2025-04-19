import 'package:firebase_auth/firebase_auth.dart';
import 'package:testing_firebase/auth/domain/entites/user_entity.dart';

class UserModel extends UserEntity{
  const UserModel({
    required String id,
    required String email,
    String? name,
}) : super(id: id, email:email, name: name);

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id':id,
      'email':email,
      'name':name
    };
  }
  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      id: user.uid,
      email: user.email ?? '',
      name: user.displayName
    );
  }
}