import 'package:firebase_auth/firebase_auth.dart';
import 'package:testing_firebase/auth/domain/usecases/usecase.dart';

import '../repositories/auth_repository.dart';

class ForgotPassword implements UseCase<void,String>{
  final AuthRepository repository;

  ForgotPassword(this.repository);

  @override
  Future<void> call(String username) async {
    return await repository.forgotPassword(username);
  }

}