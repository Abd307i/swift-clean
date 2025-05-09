import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthi{
  Future<UserCredential> loginUser(String username, String password);
  Future<UserCredential> registerUser(String username, String password);
  Future<void> forgotPassword(String username);
  Future<void> sendEmailVerification();
  Future<void> logout();
  Future<User?> getCurrentUser();
}