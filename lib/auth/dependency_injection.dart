
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:testing_firebase/auth/data/datasources/remote/firebase_auth_imp.dart';
import 'package:testing_firebase/auth/domain/usecases/send_verification_email.dart';
import 'package:testing_firebase/auth/presentation/bloc/auth_bloc.dart';

import 'data/datasources/remote/firebase_auth.dart';
import 'data/repositories/auth_repository.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/usecases/forgot_password.dart';
import 'domain/usecases/get_current.dart';
import 'domain/usecases/login_user.dart';
import 'domain/usecases/logout_user.dart';
import 'domain/usecases/register_user.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Auth
  // Bloc
  sl.registerFactory(
        () => AuthBloc(
      loginUser: sl(),
      registerUser: sl(),
      forgotPassword: sl(),
      getCurrentUser: sl(),
      logoutUser: sl(),
      sendVerificationEmail: sl()
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => RegisterUser(sl()));
  sl.registerLazySingleton(() => ForgotPassword(sl()));
  sl.registerLazySingleton(() => GetCurrentUser(sl()));
  sl.registerLazySingleton(() => LogoutUser(sl()));
  sl.registerLazySingleton(() => SendVerificationEmail(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImp(
      firebaseAuthi: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<FirebaseAuthi>(
        () => FirebaseAuthImp(FirebaseAuth.instance),
  );
}