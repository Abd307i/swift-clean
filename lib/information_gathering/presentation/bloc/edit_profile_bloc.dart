import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_firebase/information_gathering/data/models/user_info_model.dart';
import 'package:testing_firebase/information_gathering/domain/entities/user_details_entity.dart';
import 'package:testing_firebase/information_gathering/presentation/bloc/edit_profile_event.dart';
import 'package:testing_firebase/information_gathering/presentation/bloc/edit_profile_state.dart';
import 'package:testing_firebase/information_gathering/data/datasources/remote/firebase_user_details.dart';
import 'package:testing_firebase/information_gathering/data/repositories/user_details_repository_imp.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final InfoGatheringRepository infoGatheringRepository;

  EditProfileBloc({
    required this.infoGatheringRepository,
  }) : super(const EditProfileState()) {
    on<LoadUserProfile>(_onLoadUserProfile);
    on<UpdateFirstName>(_onUpdateFirstName);
    on<UpdateLastName>(_onUpdateLastName);
    on<UpdatePhoneNumber>(_onUpdatePhoneNumber);
    on<UpdateAddress>(_onUpdateAddress);
    on<SaveProfile>(_onSaveProfile);
  }

  Future<void> _onLoadUserProfile(
      LoadUserProfile event,
      Emitter<EditProfileState> emit,
      ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final UserInfoModel userInfo = await infoGatheringRepository.getUserInfo(event.userId);

      // Convert UserInfoModel to UserDetailsEntity for the UI
      final userDetails = UserDetailsEntity(
        id: userInfo.userId,
        firstName: userInfo.firstName,
        lastName: userInfo.lastName,
        phoneNumber: userInfo.phone,
        address: userInfo.address,
        email: userInfo.email
      );

      emit(state.copyWith(
        isLoading: false,
        userDetails: userDetails,
        firstName: userDetails.firstName,
        lastName: userDetails.lastName,
        phoneNumber: userDetails.phoneNumber,
        address: userDetails.address ?? '',
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load user profile: ${e.toString()}',
      ));
    }
  }

  void _onUpdateFirstName(
      UpdateFirstName event,
      Emitter<EditProfileState> emit,
      ) {
    emit(state.copyWith(firstName: event.firstName));
  }

  void _onUpdateLastName(
      UpdateLastName event,
      Emitter<EditProfileState> emit,
      ) {
    emit(state.copyWith(lastName: event.lastName));
  }

  void _onUpdatePhoneNumber(
      UpdatePhoneNumber event,
      Emitter<EditProfileState> emit,
      ) {
    emit(state.copyWith(phoneNumber: event.phoneNumber));
  }

  void _onUpdateAddress(
      UpdateAddress event,
      Emitter<EditProfileState> emit,
      ) {
    emit(state.copyWith(address: event.address));
  }

  Future<void> _onSaveProfile(
      SaveProfile event,
      Emitter<EditProfileState> emit,
      ) async {
    if (state.firstName.isEmpty) {
      emit(state.copyWith(errorMessage: 'First name cannot be empty'));
      return;
    }

    if (state.lastName.isEmpty) {
      emit(state.copyWith(errorMessage: 'Last name cannot be empty'));
      return;
    }

    if (state.phoneNumber.isEmpty) {
      emit(state.copyWith(errorMessage: 'Phone number cannot be empty'));
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: ''));

    try {
      // Create a new UserInfoModel with the updated information
      final updatedUserInfo = UserInfoModel(
        userId: state.userDetails!.id,
        firstName: state.firstName,
        lastName: state.lastName,
        phone: state.phoneNumber,
        address: state.address,
        email: state.email
      );

      await infoGatheringRepository.updateUserInfo(updatedUserInfo);

      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
        errorMessage: '',
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to update profile: ${e.toString()}',
      ));
    }
  }
}