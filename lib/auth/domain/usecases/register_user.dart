import '../repositories/auth_repository.dart';

class RegisterUser{
  final AuthRepository repository;

  RegisterUser(this.repository);

  Future<void> call(String email,
   String password,
   String firstName,
   String lastName,
   String phoneNumber) async {
    return await repository.registerUser(email,password,firstName,lastName,phoneNumber);
  }
}
