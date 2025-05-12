import 'package:testing_firebase/auth/domain/entites/user_entity.dart';
import 'package:testing_firebase/auth/domain/usecases/register_user.dart';

abstract class AuthRepository {
  Future<UserEntity> loginUser(String username, String password);
  Future<UserEntity> registerUser(RegisterUserParams params);
  Future<void> forgotPassword(String username);
  Future<void> sendEmailVerification();
  Future<void> logout();

  Future<UserEntity?> getCurrentUser();
}