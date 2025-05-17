import '../../../auth/domain/usecases/usecase.dart';
import '../repositories/profile_repository.dart';

class DeleteProfileImage implements UseCase<void, String>{
  final ProfileRepository repository;

  DeleteProfileImage(this.repository);

  @override
  Future<void> call(String imageUrl) async{
    await repository.deleteProfileImage(imageUrl);
  }
}