import 'package:firebase_auth/firebase_auth.dart';
import 'package:testing_firebase/auth/domain/usecases/register_user.dart';

abstract class FirebaseAuthi{
  Future<UserCredential> loginUser(String username, String password);
  Future<UserCredential> registerUser(RegisterUserParams params);
  Future<void> forgotPassword(String username);
  Future<void> logout();
  Future<void> sendEmailVerification();
  Future<User?> getCurrentUser();
}