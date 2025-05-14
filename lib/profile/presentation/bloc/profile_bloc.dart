import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_firebase/profile/domain/usecases/get_profile_data.dart';
import 'package:testing_firebase/profile/domain/usecases/update_profile_data.dart';
import 'package:testing_firebase/profile/domain/usecases/upload_profile_image.dart';
import 'package:testing_firebase/profile/presentation/bloc/profile_event.dart';
import 'package:testing_firebase/profile/presentation/bloc/profile_state.dart';

import '../../domain/usecases/delete_profile_image.dart';

class ProfileBloc extends Bloc<ProfileEvent,ProfileState>{
  final LoadProfileData loadProfileData;
  final DeleteProfileImage deleteProfileImage;
  final UpdateProfileData updateProfileData;
  final UploadProfileImage uploadProfileImage;

  ProfileBloc({
    required this.loadProfileData,
    required this.deleteProfileImage,
    required this.updateProfileData,
    required this.uploadProfileImage
}):super(ProfileLoading()){
    on<LoadProfileEvent> (_onLoadProfile);
    on<DeleteProfileImageEvent> (_onDeleteProfileImage);
    on<UpdateProfileEvent> (_onUpdateProfile);
    on<UploadProfileImageEvent> (_onUploadProfileImage);
  }

  Future<void> _onLoadProfile(
      LoadProfileEvent event,
      Emitter<ProfileState> emit,
      ) async {
    try {
      final profile = await loadProfileData.call(event.userId);
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> _onUpdateProfile(
      UpdateProfileEvent event,
      Emitter<ProfileState> emit,
      ) async {
    try {
      await updateProfileData.call(event.profile);
      emit(ProfileUpdated());
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> _onDeleteProfileImage(
      DeleteProfileImageEvent event,
      Emitter<ProfileState> emit,
      ) async {
    try {
      await deleteProfileImage.call(event.imageUrl);
      emit(ProfileImageDeleted());
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> _onUploadProfileImage(
      UploadProfileImageEvent event,
      Emitter<ProfileState> emit,
      ) async {
    try {
      await uploadProfileImage.call(UploadImageParams(userId:event.userId, image:event.image));
      emit(ProfileImageDeleted());
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

}