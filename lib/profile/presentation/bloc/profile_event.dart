import 'dart:io';

import 'package:testing_firebase/profile/domain/entities/profile_entity.dart';

abstract class ProfileEvent {}

class LoadProfileEvent extends ProfileEvent{
  final String userId;
  LoadProfileEvent(this.userId);
}

class UpdateProfileEvent extends ProfileEvent{
  final ProfileEntity profile;
  UpdateProfileEvent(this.profile);
}

class UploadProfileImageEvent extends ProfileEvent{
  final String userId;
  final File image;
  UploadProfileImageEvent(this.userId, this.image);
}

class DeleteProfileImageEvent extends ProfileEvent{
  final String imageUrl;
  DeleteProfileImageEvent(this.imageUrl);
}