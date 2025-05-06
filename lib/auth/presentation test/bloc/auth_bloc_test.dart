import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_firebase/auth/domain/usecases/forgot_password.dart';
import 'package:testing_firebase/auth/domain/usecases/login_user.dart';
import 'package:testing_firebase/auth/domain/usecases/logout_user.dart';
import 'package:testing_firebase/auth/domain/usecases/register_user.dart';
import 'package:testing_firebase/auth/presentation%20test/bloc/auth_event_test.dart';
import 'package:testing_firebase/auth/presentation%20test/bloc/auth_state_test.dart';

import '../../domain/entites/user_entity.dart';

class AuthBlocTest extends Bloc<AuthEventTest, AuthStateTest> {
  final LoginUser loginUser;
  final LogoutUser logoutUser;
  final ForgotPassword forgotPassword;
  final RegisterUser registerUser;


  AuthBlocTest({
    required this.loginUser,
    required this.logoutUser,
    required this.forgotPassword,
    required this.registerUser,
  }):super(AuthStateTest.unknown()){
    on<LoginEventTest>(_onLoginEventTest);
    on<RegisterEventTest>(_onRegisterEventTest);
    on<ForgotPasswordEventTest>(_onForgotPasswordEventTest);
    on<LogoutEventTest>(_onLogoutEventTest);
    on<UserChangedEventTest>(_onUserChangedEventTest);
  }

  void _onLoginEventTest(LoginEventTest event, Emitter<AuthStateTest> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final result = await loginUser(
      event.email,
      event.password,
    );

    result.fold(
          (failure) => emit(state.copyWith(
        status: AuthStatus.failure,
        errorMessage: failure.message,
      )),
          (_) => emit(state.copyWith(status: AuthStatus.authenticated)),
    );
  }

  void _onRegisterEventTest(RegisterEventTest event, Emitter<AuthStateTest> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final result = await registerUser(
      event.email,
      event.password,
      event.firstName,
      event.lastName,
      event.phoneNumber,
    );

    result.fold(
          (failure) => emit(state.copyWith(
        status: AuthStatus.failure,
        errorMessage: failure.message,
      )),
          (_) => emit(state.copyWith(status: AuthStatus.authenticated)),
    );
  }

  void _onForgotPasswordEventTest(ForgotPasswordEventTest event, Emitter<AuthStateTest> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final result = await forgotPassword(event.email);

    result.fold(
          (failure) => emit(state.copyWith(
        status: AuthStatus.failure,
        errorMessage: failure.message,
      )),
          (_) => emit(state.copyWith(
        status: AuthStatus.unauthenticated,
        infoMessage: 'Password reset email sent',
      )),
    );
  }


  Future<void> _onLogoutEventTest(LogoutEventTest event, Emitter<AuthStateTest> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final result = await logoutUser();

    result.fold(
          (failure) => emit(state.copyWith(
        status: AuthStatus.failure,
        errorMessage: failure.message,
      )),
          (_) => emit(state.copyWith(status: AuthStatus.unauthenticated)),
    );
  }

  void _onUserChangedEventTest(
      UserChangedEventTest event,
      Emitter<AuthStateTest> emit){
    if (event.user != null) {
      emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: UserEntity(
          id: event.user!.id,
          email: event.user!.email,
          firstName: event.user!.firstName,
          lastName:  event.user!.lastName,
          phoneNumber:  event.user!.phoneNumber
        ),
      ));
    } else {
      emit(state.copyWith(
        status: AuthStatus.unauthenticated,
        user: null,
      ));
    }
  }
}

