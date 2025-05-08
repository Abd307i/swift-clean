import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_firebase/auth/presentation/pages/sign_in_screen.dart';

import '../../../presentation/screens/ProfileMenuScreen.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

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
    context.read<AuthBloc>().add(LogoutEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {

        // For any other state (including AuthUnauthenticated and AuthInitial), show the sign in screen
        return SignInScreen();
      },
    );
  }
}