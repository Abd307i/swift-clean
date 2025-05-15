import 'package:equatable/equatable.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadUserProfile extends EditProfileEvent {
  final String userId;

  const LoadUserProfile({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class UpdateFirstName extends EditProfileEvent {
  final String firstName;

  const UpdateFirstName({required this.firstName});

  @override
  List<Object?> get props => [firstName];
}

class UpdateLastName extends EditProfileEvent {
  final String lastName;

  const UpdateLastName({required this.lastName});

  @override
  List<Object?> get props => [lastName];
}

class UpdatePhoneNumber extends EditProfileEvent {
  final String phoneNumber;

  const UpdatePhoneNumber({required this.phoneNumber});

  @override
  List<Object?> get props => [phoneNumber];
}

class UpdateAddress extends EditProfileEvent {
  final String address;

  const UpdateAddress({required this.address});

  @override
  List<Object?> get props => [address];
}

class SaveProfile extends EditProfileEvent {
  const SaveProfile();
}