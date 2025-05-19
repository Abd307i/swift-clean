import 'dart:io';

import '../../../auth/domain/usecases/usecase.dart';
import '../repositories/profile_repository.dart';

class UploadProfileImage implements UseCase<void, UploadImageParams>{
  final ProfileRepository repository;

  UploadProfileImage(this.repository);

  @override
  Future<void> call(UploadImageParams params) async{
    await repository.uploadProfileData(params.userId, params.image);
  }
}

class UploadImageParams {
  final String userId;
  final File image;

  UploadImageParams({required this.userId, required this.image});
}