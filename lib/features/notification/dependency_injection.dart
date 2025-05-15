import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:testing_firebase/features/notification/presentation/bloc/notification_bloc.dart';

import 'data/datasources/remote/notification_remote_data_source.dart';
import 'data/repositories/notification_repository_imp.dart';
import 'domain/usecases/get_notifications.dart';
import 'domain/usecases/mark_as_read.dart';
import 'domain/usecases/toggle_mute_notifications.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseMessaging.instance);

  // Data Sources
  sl.registerLazySingleton<NotificationDataSource>(
        () => NotificationDataSource(),
  );

  // Repositories
  sl.registerLazySingleton<NotificationRepository>(
        () => NotificationRepositoryImpl(
      sl<NotificationDataSource>(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetNotifications(sl()));
  sl.registerLazySingleton(() => ToggleMuteNotification(sl()));
  sl.registerLazySingleton(() => MarkAsRead(sl()));

  // BLoC
  sl.registerFactory(() => NotificationBloc(
    getNotifications: sl(),
    markAsRead: sl(),
    toggleMuteNotification: sl(),
  ));
}