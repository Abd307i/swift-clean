import 'dart:io';

import 'package:testing_firebase/features/profile/data/datasources/remote/profile_remote_datasource.dart';
import 'package:testing_firebase/features/profile/data/models/profile_model.dart';
import 'package:testing_firebase/features/profile/domain/entities/profile_entity.dart';
import 'package:testing_firebase/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImp implements ProfileRepository{
  final ProfileRemoteDataSources remoteDataSources;
  ProfileRepositoryImp({
    required this.remoteDataSources
});

  @override
  Future<ProfileEntity> loadProfileData(String userId) async{
    try{
      final remoteProfile = await remoteDataSources.loadProfile(userId);
      return remoteProfile;
    }catch(e){
      throw e.toString();
    }
  }

  @override
  Future<void> updateProfileData(ProfileEntity profile) async {
    try{
      await remoteDataSources.updateProfile(ProfileModel.fromEntity(profile));
    } catch(e){
      throw e.toString();
    }
  }

  @override
  Future<void> deleteProfileImage(String imageUrl) async{
    try{
      await remoteDataSources.deleteImage(imageUrl);
    } catch(e){
      throw e.toString();
    }
  }

  @override
  Future<String> uploadProfileData(String userId, File image) async {
    try {
      final imageUrl = await remoteDataSources.uploadImage(userId, image);
      return imageUrl;
    } catch (e) {
      throw Exception('Image upload failed: $e');
    }
  }

}