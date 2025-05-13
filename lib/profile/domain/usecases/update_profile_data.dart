import 'package:testing_firebase/profile/domain/entities/profile_entity.dart';

import '../../../auth/domain/usecases/usecase.dart';
import '../repositories/profile_repository.dart';

class UpdateProfileData implements UseCase<void, ProfileEntity>{
  final ProfileRepository repository;

  UpdateProfileData(this.repository);

  @override
  Future<void> call(ProfileEntity profile) async{
    await repository.updateProfileData(profile);
  }
}