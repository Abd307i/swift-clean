import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_firebase/auth/presentation/bloc/auth_bloc.dart';
import 'package:testing_firebase/auth/presentation/bloc/auth_state.dart';
import 'package:testing_firebase/auth/presentation/pages/register_page.dart';
import 'package:testing_firebase/services/presentation/pages/service_page.dart';

import 'login_page.dart';

class AuthPage extends StatelessWidget{
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc,AuthState>(
      listener: (context,state){
        if(state is AuthAuthenticated){
          //Navigator.push(context,MaterialPageRoute(builder: (context) => const LoginPage()));
        }
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Authentication'),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Login'),
                Tab(text: 'Register'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              LoginPage(),
              RegisterPage(),
            ],
          ),
        ),
      ),
    );
  }

}