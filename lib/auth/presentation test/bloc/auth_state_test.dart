import 'package:equatable/equatable.dart';

import '../../domain/entites/user_entity.dart';

enum AuthStatus { unknown, authenticated, unauthenticated, loading, failure }

class AuthStateTest extends Equatable {
  final AuthStatus status;
  final UserEntity? user;
  final String? errorMessage;
  final String? infoMessage;

  const AuthStateTest({
    this.status = AuthStatus.unknown,
    this.user,
    this.errorMessage,
    this.infoMessage,
  });

  const AuthStateTest.unknown() : this();

  const AuthStateTest.authenticated(UserEntity user)
      : this(status: AuthStatus.authenticated, user: user);

  const AuthStateTest.unauthenticated()
      : this(status: AuthStatus.unauthenticated);

  const AuthStateTest.loading()
      : this(status: AuthStatus.loading);

  const AuthStateTest.failure(String errorMessage)
      : this(status: AuthStatus.failure, errorMessage: errorMessage);

  AuthStateTest copyWith({
    AuthStatus? status,
    UserEntity? user,
    String? errorMessage,
    String? infoMessage,
  }) {
    return AuthStateTest(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
      infoMessage: infoMessage ?? this.infoMessage,
    );
  }

  @override
  List<Object?> get props => [status, user, errorMessage, infoMessage];
}