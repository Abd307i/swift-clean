import 'package:equatable/equatable.dart';
import 'package:testing_firebase/information_gathering/domain/entities/user_details_entity.dart';

class EditProfileState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String errorMessage;
  final UserDetailsEntity? userDetails;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String address;
  final String email;

  const EditProfileState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage = '',
    this.userDetails,
    this.firstName = '',
    this.lastName = '',
    this.phoneNumber = '',
    this.address = '',
    this.email = ''
  });

  EditProfileState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    UserDetailsEntity? userDetails,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? address,
    String? email
  }) {
    return EditProfileState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      userDetails: userDetails ?? this.userDetails,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      email: email ?? this.email
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isSuccess,
    errorMessage,
    userDetails,
    firstName,
    lastName,
    phoneNumber,
    address,
    email

  ];
}