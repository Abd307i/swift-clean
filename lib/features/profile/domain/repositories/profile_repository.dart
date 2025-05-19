import 'dart:io';

import 'package:testing_firebase/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileRepository{
  Future<void> updateProfileData(ProfileEntity profile);
  Future<ProfileEntity> loadProfileData(String userId);
  Future<String> uploadProfileData(String userId, File image);
  Future<void> deleteProfileImage(String imageUrl);
}