import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_firebase/auth/presentation/bloc/auth_state.dart';

import '../../domain/usecases/forgot_password.dart';
import '../../domain/usecases/get_current.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/usecases/logout_user.dart';
import '../../domain/usecases/register_user.dart';
import '../../domain/usecases/usecase.dart';
import 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent,AuthState>{
  final LoginUser loginUser;
  final RegisterUser registerUser;
  final ForgotPassword forgotPassword;
  final GetCurrentUser getCurrentUser;
  final LogoutUser logoutUser;

  AuthBloc({
    required this.loginUser,
    required this.registerUser,
    required this.forgotPassword,
    required this.getCurrentUser,
    required this.logoutUser,
  }) : super(AuthInitial()) {
    on<LoginEvent>(_onLoginEvent);
    on<RegisterEvent>(_onRegisterEvent);
    on<ForgotPasswordEvent>(_onForgotPasswordEvent);
    on<GetCurrentUserEvent>(_onGetCurrentUserEvent);
    on<LogoutEvent>(_onLogoutEvent);
  }
  Future<void> _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await loginUser.call(LoginUserParams(
        email: event.email,
        password: event.password,
      ));
      emit(AuthAuthenticated(user: user, message: "Logged In"));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onRegisterEvent(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await registerUser.call(RegisterUserParams(
        email: event.email,
        password: event.password,
      ));
      emit(RegistrationSuccess(message: "Done"));
      
    }  catch (e) {
      print("yaaaaa");
      String errorMessage = '';
        if (e == 'email-already-in-use') {
          errorMessage = "Email already in use";
        } else if (e == 'weak-password') {
          errorMessage = "Weak password";
        } else if (e == 'invalid-email') {
          errorMessage = "Invalid email address";
        } else {
          errorMessage = "An error occurred";
        }
      emit(AuthError(message: errorMessage));
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
    emit(AuthLoading());
    try {
      final user = await getCurrentUser.call(NoParams());
      if (user != null) {
        emit(AuthAuthenticated(user: user, message: "Logged In"));
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
}


