import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:testing_firebase/features/auth/presentation/pages/sign_in_screen.dart';

import 'features/auth/dependency_injection.dart' as di;
import 'features/profile/dependency_injection.dart' as dii;
import 'features/notification/dependency_injection.dart' as ddi;
import 'features/order history/dependency_injection.dart' as ddii;
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
  await ddi.init();
  await ddii.init();
  //await setupDependencies();

  runApp(MyApp());
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
        home: SignInScreen(),
      ),
    );
  }
}