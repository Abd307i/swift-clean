import 'package:testing_firebase/auth/domain/repositories/auth_repository.dart';
import 'package:testing_firebase/auth/domain/usecases/usecase.dart';

class LogoutUser implements UseCase<void, NoParams>{
  final AuthRepository repository;

  LogoutUser(this.repository);

  @override
  Future<void> call(NoParams params) async {
    return await repository.logout();
  }

}