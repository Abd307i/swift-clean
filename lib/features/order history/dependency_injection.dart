import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:testing_firebase/features/order%20history/data/datasources/remote/firebase_order_history.dart';
import 'package:testing_firebase/features/order%20history/data/repositories/order_history_repository_imp.dart';
import 'package:testing_firebase/features/order%20history/domain/repositories/order_history_repository.dart';
import 'package:testing_firebase/features/order%20history/domain/usecases/get_order_history.dart';
import 'package:testing_firebase/features/order%20history/presentation/bloc/order_history_bloc.dart';
import 'package:testing_firebase/features/order%20history/presentation/bloc/order_history_event.dart';

final sl = GetIt.instance;

Future<void> init() async{
  sl.registerFactory(() => OrderHistoryBloc(
    getOrderHistory: sl()
  ));

  sl.registerLazySingleton(() => GetOrderHistory(sl()));

  sl.registerLazySingleton<OrderHistoryRepository>(
        () => OrderHistoryRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<FirebaseOrderHistory>(
        () => FirebaseOrderHistory(FirebaseFirestore.instance),
  );
}