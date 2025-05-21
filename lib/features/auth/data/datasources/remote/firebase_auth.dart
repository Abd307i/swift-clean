import 'package:firebase_auth/firebase_auth.dart';
import 'package:testing_firebase/features/auth/domain/usecases/register_user.dart';

import '../../../domain/entites/user_entity.dart';
import '../../models/UserModel.dart';

abstract class FirebaseAuthi{
  Future<UserCredential> loginUser(String username, String password);
  Future<UserCredential> registerUser(RegisterUserParams params);
  Future<void> forgotPassword(String username);
  Future<void> logout();
  Future<void> sendEmailVerification();
  Future<UserModel> getCurrentUser();
}