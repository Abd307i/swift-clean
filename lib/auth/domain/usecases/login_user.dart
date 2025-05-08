import 'package:testing_firebase/auth/domain/entites/user_entity.dart';
import 'package:testing_firebase/auth/domain/repositories/auth_repository.dart';
import 'package:testing_firebase/auth/domain/usecases/usecase.dart';

class LoginUser implements UseCase<UserEntity,LoginUserParams>{
  final AuthRepository repository;

  LoginUser(this.repository);

  @override
  Future<UserEntity> call(LoginUserParams params) async {
    final user = await repository.loginUser(params.email, params.password);
    if(!user.emailVerified){
      throw 'Please Verify Your Email First';
    }
    return user;
  }

}
class LoginUserParams {
  final String email;
  final String password;

  LoginUserParams({required this.email, required this.password});
}