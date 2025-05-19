import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:testing_firebase/features/services/data/datasource/remote/firebase_order.dart';
import 'package:testing_firebase/features/services/data/datasource/remote/firebase_service.dart';
import 'package:testing_firebase/features/services/data/repositories/order_repository_imp.dart';
import 'package:testing_firebase/features/services/data/repositories/service_repositories_imp.dart';
import 'package:testing_firebase/features/services/domain/repositories/order_repository.dart';
import 'package:testing_firebase/features/services/domain/repositories/service_repository.dart';
import 'package:testing_firebase/features/services/domain/usecases/add_to_cart.dart';
import 'package:testing_firebase/features/services/domain/usecases/confirm_order.dart';
import 'package:testing_firebase/features/services/domain/usecases/get_cart_items.dart';
import 'package:testing_firebase/features/services/domain/usecases/get_items_by_service.dart';
import 'package:testing_firebase/features/services/domain/usecases/get_order.dart';
import 'package:testing_firebase/features/services/domain/usecases/get_services.dart';
import 'package:testing_firebase/features/services/domain/usecases/remove_from_cart.dart';
import 'package:testing_firebase/features/services/presentation/bloc/cart_bloc.dart';
import 'package:testing_firebase/features/services/presentation/bloc/order_bloc.dart';
import 'package:testing_firebase/features/services/presentation/bloc/service_bloc.dart';

final sl = GetIt.instance;

Future<void> inti() async{
  sl.registerFactory(()
  => ServiceBloc(getServices: sl(), getItemByService:sl()));

  sl.registerFactory(() => OrderBloc(
      getOrder: sl(),
      confirmOrder: sl()));

  sl.registerFactory(()
  => CartBloc(addToCart: sl(),
      removeFromCart: sl(),
      getCartItems: sl()));

  sl.registerLazySingleton(() => GetServices(sl()));
  sl.registerLazySingleton(() => GetItemByService(sl()));
  sl.registerLazySingleton(() => AddToCart(sl()));
  sl.registerLazySingleton(() => GetCartItems(sl()));
  sl.registerLazySingleton(() => RemoveFromCart(sl()));
  sl.registerLazySingleton(() => GetOrder(sl()));
  sl.registerLazySingleton(() => ConfirmOrder(sl()));

  sl.registerLazySingleton<OrderRepository>(
      () => OrderRepositoryImp(sl())
  );

  sl.registerLazySingleton<ServiceRepository>(
      () => ServiceRepositoryImp(dataSource: sl())
  );

  sl.registerLazySingleton(
      () => FirebaseOrder(FirebaseFirestore.instance)
  );

  sl.registerLazySingleton(
      () => FirebaseServiceDataSourceImp(FirebaseFirestore.instance)
  );
}