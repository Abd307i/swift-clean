import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:testing_firebase/features/profile/data/datasources/remote/firebase_order_history.dart';
import 'package:testing_firebase/features/profile/data/repositories/order_history_repository_imp.dart';
import 'package:testing_firebase/features/profile/domain/repositories/order_history_repository.dart';
import 'package:testing_firebase/features/profile/domain/usecases/get_order_history.dart';
import 'package:testing_firebase/services/data/datasource/remote/firebase_service.dart';
import 'package:testing_firebase/services/data/repositories/service_repositories_imp.dart';
import 'package:testing_firebase/services/domain/repositories/service_repository.dart';
import 'package:testing_firebase/services/domain/usecases/get_services.dart';
import 'package:testing_firebase/services/presentation/bloc/service_bloc.dart';

import 'auth/dependency_injection.dart' as di;
import 'auth/presentation/bloc/auth_bloc.dart';
import 'auth/presentation/bloc/auth_event.dart';
import 'auth/presentation/pages/auth_page.dart';

final getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await di.init();
  //await setupDependencies();

  runApp(MyApp());
}

Future<void> setupDependencies() async {
  getIt.registerSingleton<FirebaseServiceDataSource>(
    FirebaseServiceDataSource(),
  );

  getIt.registerSingleton<ServiceRepository>(
    ServiceRepositoryImp(getIt<FirebaseServiceDataSource>()),
  );

  getIt.registerSingleton<GetServices>(
    GetServices(getIt<ServiceRepository>()),
  );

  getIt.registerFactory<ServiceBloc>(
        () => ServiceBloc(getIt<GetServices>()),
  );


  // For OrderHistory

  getIt.registerSingleton<FirebaseOrderHistory>(
    FirebaseOrderHistory(),
  );

  getIt.registerSingleton<OrderHistoryRepositoryImpl>(
    OrderHistoryRepositoryImpl(getIt<FirebaseOrderHistory>()),
  );

  getIt.registerSingleton<GetOrderHistory>(
    GetOrderHistory(getIt<OrderHistoryRepository>()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<AuthBloc>()..add(GetCurrentUserEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Auth',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthPage(),
      ),
    );
  }
}