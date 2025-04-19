import 'package:testing_firebase/auth/data/datasources/remote/firebase_auth.dart';
import 'package:testing_firebase/auth/data/models/UserModel.dart';
import 'package:testing_firebase/auth/domain/entites/user_entity.dart';
import 'package:testing_firebase/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImp implements AuthRepository{
  final FirebaseAuthi firebaseAuthi;

  AuthRepositoryImp({
    required this.firebaseAuthi
});

  @override
  Future<void> forgotPassword(String username) async{
    try {
      await firebaseAuthi.forgotPassword(username);
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<UserEntity?> getCurrentUser() async{
    try {
      final user = await firebaseAuthi.getCurrentUser();
      if (user != null) {
        final userModel = UserModel.fromFirebaseUser(user);
        return userModel;
      }
      return null;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<UserModel> loginUser(String username, String password) async {
    try {
      final userCredential = await firebaseAuthi.loginUser(username, password);
      final userModel = UserModel.fromFirebaseUser(userCredential.user!);
      return userModel;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> logout() async{
    try {
      await firebaseAuthi.logout();
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<UserModel> registerUser(String username, String password) async {
    try {
      final userCredential = await firebaseAuthi.registerUser(username, password);
      final userModel = UserModel.fromFirebaseUser(userCredential.user!);
      return userModel;
    } catch (e) {
      throw e.toString();
    }
  }
}