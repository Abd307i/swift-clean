import 'package:firebase_auth/firebase_auth.dart';
import 'package:testing_firebase/auth/domain/entites/user_entity.dart';

abstract class AuthRepository {
  Future<void> loginUser(String username, String password);
  Future<void> registerUser(String username, String password, String firstName, String lastName, String phoneNumber);
  Future<void> forgotPassword(String username);
  Future<void> logout();

  Stream<User?> authStateChanges();
}