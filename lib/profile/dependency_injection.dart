// Profile Feature

import 'package:get_it/get_it.dart';
import 'package:testing_firebase/profile/data/datasources/remote/profile_remote_datasource.dart';
import 'package:testing_firebase/profile/data/repositories/profile_repository_imp.dart';
import 'package:testing_firebase/profile/domain/usecases/delete_profile_image.dart';
import 'package:testing_firebase/profile/domain/usecases/get_profile_data.dart';
import 'package:testing_firebase/profile/presentation/bloc/profile_bloc.dart';

import 'domain/repositories/profile_repository.dart';
import 'domain/usecases/update_profile_data.dart';
import 'domain/usecases/upload_profile_image.dart';

final sl = GetIt.instance;

Future<void> init() async{
  sl.registerFactory(() => ProfileBloc(
    loadProfileData: sl(),
    updateProfileData: sl(),
    uploadProfileImage: sl(),
    deleteProfileImage: sl(),
  ));

  sl.registerLazySingleton(() => LoadProfileData(sl()));
  sl.registerLazySingleton(() => UpdateProfileData(sl()));
  sl.registerLazySingleton(() => UploadProfileImage(sl()));
  sl.registerLazySingleton(() => DeleteProfileImage(sl()));

  sl.registerLazySingleton<ProfileRepository>(
        () => ProfileRepositoryImp(
      remoteDataSources: sl()
    ),
  );

  sl.registerLazySingleton<ProfileRemoteDataSources>(
        () => ProfileRemoteDataSources(sl(), sl()),
  );
}

