import 'package:testing_firebase/features/auth/domain/entites/user_entity.dart';
import 'package:testing_firebase/features/auth/domain/usecases/usecase.dart';

import '../entites/adddress_entity.dart';
import '../repositories/auth_repository.dart';

class RegisterUser implements UseCase<UserEntity,RegisterUserParams>{
  final AuthRepository repository;

  RegisterUser(this.repository);

  @override
  Future<UserEntity> call(RegisterUserParams params) async {
    return await repository.registerUser(params);
  }
}


class RegisterUserParams {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String phone; // With country code
  final String? address;
  final String userType;

  RegisterUserParams({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.userType,
    this.address,
});
}
