import 'package:testing_firebase/profile/domain/entities/profile_entity.dart';
import 'package:testing_firebase/profile/domain/repositories/profile_repository.dart';
import 'package:testing_firebase/profile/domain/usecases/usecase.dart';

class LoadProfileData implements UseCase<ProfileEntity, String>{
  final ProfileRepository repository;

  LoadProfileData(this.repository);

  @override
  Future<ProfileEntity> call(String userId) async {
    return await repository.loadProfileData(userId);
  }
}