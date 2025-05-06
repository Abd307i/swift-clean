import 'package:testing_firebase/auth/domain/entites/user_entity.dart';

abstract class UserDetailRepository{
  Future<UserEntity> getUserDetails(String userId);
  Future<void> addUser(UserEntity user);
}