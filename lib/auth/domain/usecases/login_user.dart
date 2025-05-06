import '../repositories/auth_repository.dart';

class LoginUser{
  final AuthRepository repository;

  LoginUser(this.repository);

  Future<Either<Failure, void>> call({required String username, required String password}) async {
    return await repository.loginUser(username,password);

  }
}