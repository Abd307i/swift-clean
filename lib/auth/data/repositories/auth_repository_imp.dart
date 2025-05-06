import 'package:firebase_auth/firebase_auth.dart';
import 'package:testing_firebase/auth/data/datasources/remote/firebase_auth.dart';

import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImp implements AuthRepository{
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImp({
    required this.remoteDataSource
});

  @override
  Future<void> forgotPassword(String username) async{
    try {
      await remoteDataSource.forgotPassword(username);
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> loginUser(String username, String password) async {
    try {
      await remoteDataSource.loginUser(username, password);
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> logout() async{
    try {
      await remoteDataSource.logout();
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> registerUser(
       String username,
       String password,
       String firstName,
       String lastName,
       String phoneNumber) async {
    try {
      await remoteDataSource.registerUser(username,password,firstName,lastName,phoneNumber);
    } catch (e) {
      throw e.toString();
    }
 }

  @override
  Stream <User?> authStateChanges(){
    return remoteDataSource.authStateChanges;
  }

}