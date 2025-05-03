import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_firebase/auth/data/repositories/auth_repository_imp.dart';
import 'package:testing_firebase/auth/presentation/bloc/auth_state.dart';
import 'package:testing_firebase/core/errors/firebase_auth_helper.dart';

import '../../domain/usecases/forgot_password.dart';
import '../../domain/usecases/get_current.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/usecases/logout_user.dart';
import '../../domain/usecases/register_user.dart';
import '../../domain/usecases/send_verification_email.dart';
import '../../domain/usecases/usecase.dart';
import 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUser loginUser;
  final RegisterUser registerUser;
  final ForgotPassword forgotPassword;
  final GetCurrentUser getCurrentUser;
  final LogoutUser logoutUser;
  final SendVerificationEmail sendVerificationEmail;

  AuthBloc({
    required this.loginUser,
    required this.registerUser,
    required this.forgotPassword,
    required this.getCurrentUser,
    required this.logoutUser,
    required this.sendVerificationEmail,
  }) : super(AuthInitial()) {
    on<LoginEvent>(_onLoginEvent);
    on<RegisterEvent>(_onRegisterEvent);
    on<ForgotPasswordEvent>(_onForgotPasswordEvent);
    on<GetCurrentUserEvent>(_onGetCurrentUserEvent);
    on<LogoutEvent>(_onLogoutEvent);
    on<SendVerificationEmailEvent>(_onSendVerificationEmailEvent);
  }

  Future<void> _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await loginUser.call(LoginUserParams(
        email: event.email,
        password: event.password,
      ));

      if (user.emailVerified) {
        emit(AuthAuthenticated(
            user: user,
            message: "Login successful! Welcome back."
        ));
      } else {
        emit(VerificationEmailSent(
            message: 'Please verify your email first. We sent a verification link to ${event.email}'
        ));
      }
    } on FirebaseAuthException catch (e) {
      final errorMessage = getFirebaseAuthErrorMessage(e);
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        emit(AuthError(message: 'Invalid email or password. Please try again.'));
      } else {
        emit(AuthError(message: errorMessage));
      }
    } catch (e) {
      emit(AuthError(message: 'An unexpected error occurred. Please try again.'));
    }
  }

  Future<void> _onRegisterEvent(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await registerUser.call(RegisterUserParams(
        email: event.email,
        password: event.password,
      ));
      emit(RegistrationSuccess(message: "Check Your Email For Verification"));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(message: getFirebaseAuthErrorMessage(e)));
    } catch(e){
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onForgotPasswordEvent(ForgotPasswordEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await forgotPassword.call(event.email);
      emit(ForgotPasswordSuccess());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onGetCurrentUserEvent(GetCurrentUserEvent event, Emitter<AuthState> emit) async {
    try {
      final user = await getCurrentUser.repository.getCurrentUser();
      if (user != null) {
        emit(AuthAuthenticated(user: user, message: ""));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onLogoutEvent(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await logoutUser.call(NoParams());
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onSendVerificationEmailEvent(
      SendVerificationEmailEvent event,
      Emitter<AuthState> emit
      ) async {
    emit(AuthLoading());
    try {
      await sendVerificationEmail.call(NoParams());
      emit(VerificationEmailSent(message: 'Check Your Email For Verification'));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}