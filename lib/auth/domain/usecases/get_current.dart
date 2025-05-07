import 'package:testing_firebase/auth/domain/entites/user_entity.dart';
import 'package:testing_firebase/auth/domain/repositories/auth_repository.dart';
import 'package:testing_firebase/auth/domain/usecases/usecase.dart';

class GetCurrentUser implements UseCase<UserEntity?, NoParams>{
  final AuthRepository repository;

  GetCurrentUser(this.repository);

  @override
  Future<UserEntity?> call(NoParams params) async {
    return await repository.getCurrentUser();
  }
}