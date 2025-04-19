import 'package:testing_firebase/auth/domain/usecases/usecase.dart';

import '../repositories/auth_repository.dart';

class CheckEmailVerification implements UseCase<bool, NoParams> {
  final AuthRepository repository;
  CheckEmailVerification(this.repository);

  @override
  Future<bool> call(NoParams params) async {
    final user = await repository.getCurrentUser();
    return user?.emailVerified ?? false;
  }
}