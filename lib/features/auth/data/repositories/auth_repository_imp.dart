import 'package:testing_firebase/features/auth/data/datasources/remote/firebase_auth.dart';
import 'package:testing_firebase/features/auth/data/models/UserModel.dart';
import 'package:testing_firebase/features/auth/domain/entites/user_entity.dart';
import 'package:testing_firebase/features/auth/domain/repositories/auth_repository.dart';
import 'package:testing_firebase/features/auth/domain/usecases/register_user.dart';


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
      return await firebaseAuthi.getCurrentUser();
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<UserEntity?> loginUser(String username, String password) async {
    try {
      final userCredential = await firebaseAuthi.loginUser(username, password);

      final userModel = await getCurrentUser();

      //final userModel = UserModel.fromFirebaseUser(userCredential.user!);

      if (!userCredential.user!.emailVerified) {
        await firebaseAuthi.sendEmailVerification();
        throw ('Please verify your email first');
      }

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
  Future<UserModel> registerUser(RegisterUserParams params) async {
    try {
      final userCredential = await firebaseAuthi.registerUser(params);
      final userModel = UserModel.fromFirebaseUser(userCredential.user!);
      return userModel;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    try {
      await firebaseAuthi.sendEmailVerification();
    } catch (e) {
      throw e.toString();
    }
  }
}