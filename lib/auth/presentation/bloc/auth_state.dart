import 'package:equatable/equatable.dart';

import '../../domain/entites/user_entity.dart';

abstract class AuthState extends Equatable{
  const AuthState();

  @override
  List<Object?> get props => [];
}
class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class RegistrationSuccess extends AuthState {
  final String message;
  const RegistrationSuccess({required this.message});
  @override
  List<Object> get props => [message];
}

class AuthAuthenticated extends AuthState {
  final UserEntity user;
  final String message;
  const AuthAuthenticated({required this.user, required this.message});

  @override
  List<Object> get props => [user];
}

class ForgotPasswordSuccess extends AuthState {}

class AuthUnauthenticated extends AuthState {}


class AuthError extends AuthState {
  final String message;

  const AuthError({required this.message});

  @override
  List<Object> get props => [message];
}