import 'package:testing_firebase/auth/domain/entites/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> loginUser(String username, String password);
  Future<UserEntity> registerUser(String username, String password);
  Future<void> forgotPassword(String username);
  Future<void> logout();

  Future<UserEntity?> getCurrentUser();

  sendEmailVerification() {}
}