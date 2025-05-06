import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {
  Future<void> loginUser(String username, String password);
  Future<void> registerUser(
      String username,
      String password,
      String firstName,
      String lastName,
      String phoneNumber);

  Future<void> forgotPassword(String username);
  Future<void> sendEmailVerification();
  Future<void> logout();
  Stream<User?> get authStateChanges;
}