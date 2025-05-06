import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_firebase/auth/presentation%20test/bloc/auth_bloc_test.dart';
import 'package:testing_firebase/auth/presentation%20test/bloc/auth_event_test.dart';
import 'package:testing_firebase/auth/presentation%20test/bloc/auth_state_test.dart';
import 'package:testing_firebase/auth/presentation/bloc/auth_bloc.dart';
import 'package:testing_firebase/auth/presentation/bloc/auth_event.dart';
import 'package:testing_firebase/auth/presentation/bloc/auth_state.dart';
import 'package:testing_firebase/auth/presentation/pages/sign_in_screen.dart.dart' show SignInScreen;
import 'package:testing_firebase/presentation/screens/ProfileMenuScreen.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  void initState() {
    super.initState();
    // For testing purposes, we can force logout
    // Comment this out when you want normal login flow
    context.read<AuthBlocTest>().add(LogoutEventTest());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBlocTest, AuthStateTest>(
      builder: (context, state) {
        // Show loading indicator while checking auth status
        if (state is AuthLoadingTest) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // If authenticated, show the profile screen
        if (state is AuthAuthenticatedTest) {
          return SSwitchTheme();
        }

        // For any other state (including AuthUnauthenticated and AuthInitial), show the sign in screen
        return SignInScreen();
      },
    );
  }
}