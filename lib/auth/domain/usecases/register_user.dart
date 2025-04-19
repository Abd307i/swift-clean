import 'package:testing_firebase/auth/domain/entites/user_entity.dart';
import 'package:testing_firebase/auth/domain/usecases/usecase.dart';

import '../repositories/auth_repository.dart';

class RegisterUser implements UseCase<UserEntity,RegisterUserParams>{
  final AuthRepository repository;

  RegisterUser(this.repository);

  @override
  Future<UserEntity> call(RegisterUserParams params) async {
    return await repository.registerUser(params.email, params.password);
  }
}


class RegisterUserParams {
  final String email;
  final String password;

  RegisterUserParams({required this.email, required this.password});
}
