import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:testing_firebase/services/data/datasource/remote/firebase_service.dart';
import 'package:testing_firebase/services/data/repositories/service_repositories_imp.dart';
import 'package:testing_firebase/services/domain/repositories/service_repository.dart';
import 'package:testing_firebase/services/domain/usecases/get_services.dart';
import 'package:testing_firebase/services/presentation/bloc/service_bloc.dart';
import 'package:testing_firebase/services/presentation/bloc/service_event.dart';
import 'package:testing_firebase/services/presentation/pages/service_page.dart';

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
        home: const AuthPage(),
      ),
    );
  }
}