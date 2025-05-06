import 'package:testing_firebase/auth/domain/entites/user_entity.dart';
import 'package:testing_firebase/auth/domain/usecases/usecase.dart';

import '../repositories/auth_repository.dart';

class GetCurrentUser implements UseCase<UserEntity?, NoParams>{
  final AuthRepository repository;

  GetCurrentUser(this.repository);

  @override
  Future<UserEntity?> call(NoParams params) async {
    return await repository.getCurrentUser();
  }
}