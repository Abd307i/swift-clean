import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:testing_firebase/features/order history/data/datasources/remote/firebase_order_history.dart';
import 'package:testing_firebase/features/order history/data/repositories/order_history_repository_imp.dart';
import 'package:testing_firebase/features/order history/domain/repositories/order_history_repository.dart';
import 'package:testing_firebase/features/order history/domain/usecases/get_order_history.dart';
import 'package:testing_firebase/features/services/data/datasource/remote/firebase_service.dart';
import 'package:testing_firebase/features/services/data/repositories/service_repositories_imp.dart';
import 'package:testing_firebase/features/services/domain/usecases/get_items_by_service.dart';
import 'package:testing_firebase/features/services/domain/usecases/get_services.dart';
import 'package:testing_firebase/features/services/presentation/bloc/service_bloc.dart';
import 'package:testing_firebase/features/services/presentation/pages/service_page.dart';

import 'features/auth/dependency_injection.dart' as di;
import 'features/profile/dependency_injection.dart' as dii;
import 'features/services/dependency_injection.dart' as diii;
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';


final getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await di.init();
  await dii.init();
  await diii.inti();
  //await setupDependencies();

  runApp(MyApp());
}

Future<void> setupDependencies() async {

  getIt.registerFactory(
          () => ServiceBloc(
      getServices: getIt(),
      getItemByService: getIt()
  ));

  getIt.registerSingleton(() => GetServices(getIt()));
  getIt.registerSingleton(() => GetItemByService(getIt()));

  getIt.registerSingleton(
          () => ServiceRepositoryImp(dataSource: getIt())
  );

  getIt.registerSingleton(
          () => FirebaseServiceDataSourceImp(getIt())
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
          create: (context) => di.sl<AuthBloc>()..add(LogoutEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Auth',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ServicesPage(),
      ),
    );
  }
}