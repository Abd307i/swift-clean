import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../presentation/screens/ProfileMenuScreen.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_text_field.dart';
import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if(state is AuthAuthenticated){
          AwesomeDialog(context: context,
            dialogType: DialogType.success,
            animType: AnimType.topSlide,
            title : 'Success',
            btnOkOnPress:() =>  {
            Navigator.push(context,
            MaterialPageRoute(builder: (context) => SSwitchTheme()))
            },
            desc : state.message,
          ).show();

        }
        if(state is VerificationEmailSent){
          AwesomeDialog(context: context,
            dialogType: DialogType.info,
            animType: AnimType.topSlide,
            title : 'Alert',
            desc : state.message,
          ).show();
        }
        if (state is AuthError) {
          AwesomeDialog(context: context,
            dialogType: DialogType.error,
            animType: AnimType.topSlide,
            title : 'Error',
            desc : state.message,
          ).show();
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                AuthTextField(
                  controller: _emailController,
                  labelText: 'Email',
                  validator: (value) => value,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                AuthTextField(
                  controller: _passwordController,
                  labelText: 'Password',
                  validator: (value) => value,
                  obscureText: true,
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordPage(),
                        ),
                      );
                    },
                    child: const Text('Forgot Password?'),
                  ),
                ),
                const SizedBox(height: 24),
                AuthButton(
                  text: 'Login',
                  onPressed: () {
                    //if (_formKey.currentState!.validate()) {
                      context.read<AuthBloc>().add(LoginEvent(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                      ));
                    //}
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}