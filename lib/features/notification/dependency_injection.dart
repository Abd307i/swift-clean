import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:testing_firebase/features/notification/presentation/bloc/notification_bloc.dart';

import 'data/datasources/remote/notification_remote_data_source.dart';
import 'data/repositories/notification_repository_imp.dart';
import 'domain/repositories/notification_repository.dart';
import 'domain/usecases/get_notifications.dart';
import 'domain/usecases/mark_as_read.dart';
import 'domain/usecases/toggle_mute_notifications.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  //sl.registerLazySingleton(() => GetNotifications(sl()));

  // Data Sources
  sl.registerLazySingleton<NotificationDataSource>(
        () => NotificationDataSource(FirebaseFirestore.instance),
  );

  sl.registerLazySingleton<FirebaseFirestore>(()=> FirebaseFirestore.instance);

  // Repositories
  sl.registerLazySingleton<NotificationRepository>(
        () => NotificationRepositoryImpl(sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetNotifications(sl()));
  sl.registerLazySingleton(() => GetStreamNotifications(sl()));
  //sl.registerLazySingleton(() => ToggleMuteNotification(sl()));
  //sl.registerLazySingleton(() => MarkAsRead(sl()));

  // BLoC
  sl.registerFactory(() => NotificationBloc(
    getNotifications: sl(),
    getStreamNotifications: sl(),
    fireStore: sl(),
    //markAsRead: sl(),
    //toggleMuteNotification: sl(),
  ));
}