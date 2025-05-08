
import 'package:equatable/equatable.dart';

import '../../domain/entites/adddress_entity.dart';

abstract class AuthEvent extends Equatable{
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class RegisterEvent extends AuthEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String phone;
  final AddressEntity? address;

  const RegisterEvent({required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phone,
    this.address,});

  @override
  List<Object> get props => [email, password,firstName,lastName,phone];
}

class ForgotPasswordEvent extends AuthEvent {
  final String email;

  const ForgotPasswordEvent({required this.email});

  @override
  List<Object> get props => [email];
}

class GetCurrentUserEvent extends AuthEvent {}

class SendVerificationEmailEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}
