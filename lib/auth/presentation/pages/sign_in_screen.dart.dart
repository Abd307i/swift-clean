import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_firebase/auth/presentation%20test/bloc/auth_bloc_test.dart';
import 'package:testing_firebase/auth/presentation%20test/bloc/auth_event_test.dart';
import 'package:testing_firebase/auth/presentation%20test/bloc/auth_state_test.dart';
import 'package:testing_firebase/auth/presentation/bloc/auth_bloc.dart';
import 'package:testing_firebase/auth/presentation/bloc/auth_event.dart';
import 'package:testing_firebase/auth/presentation/bloc/auth_state.dart';
import 'package:testing_firebase/auth/presentation/pages/forgot_password_page.dart';
import 'package:testing_firebase/auth/presentation/pages/sign_up_screen.dart'
    show SignUpScreen;
import 'package:testing_firebase/presentation/screens/ProfileMenuScreen.dart';

import '../../../information_gathering/presentation/pages/info_page.dart';

class SignInScreen extends StatefulWidget {
  static const String routeName = '/sign-in';

  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _isInitialBuild = true;

  @override
  void initState() {
    super.initState();
    // Check for current user after first build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthBlocTest>().add(LogoutEventTest());
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBlocTest, AuthStateTest>(
      listener: (context, state) {
        // Skip showing dialogs during initial build
        if (_isInitialBuild) {
          _isInitialBuild = false;
          return;
        }

        if (state is AuthAuthenticatedTest) {
          // NEW: Enhanced success dialog
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.topSlide,
            title: 'Welcome!', // NEW: More welcoming title
            btnOkOnPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SSwitchTheme()),
              );
            },
            desc: state.message,
          ).show();
        }
        else if (state is VerificationEmailSentTest) {
          // NEW: Warning dialog for unverified email
          AwesomeDialog(
            context: context,
            dialogType: DialogType.warning, // NEW: Changed to warning style
            animType: AnimType.topSlide,
            title: 'Email Verification Required', // NEW: More specific title
            desc: state.message,
            btnOkOnPress: () {},
          ).show();
        }
        else if (state is AuthErrorTest) {
          // NEW: Enhanced error dialog
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.topSlide,
            title: 'Login Failed', // NEW: Clear error title
            desc: state.message,
            btnOkText: 'Try Again', // NEW: Action-oriented button text
            btnOkOnPress: () {},
          ).show();
        }
      },
      builder: (context, state) {
        if (state is AuthLoadingTest) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 30),
                    const Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E4053),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Sign In with us to get exclusive Laundry services.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 40),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        suffixIcon: const Icon(Icons.visibility_off),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          onChanged: (value) {
                            setState(() {
                              _rememberMe = value ?? false;
                            });
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const Text('Remember me'),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPasswordPage(),
                              ),
                            );
                          },
                          child: const Text(
                            'Forgot Password',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthBlocTest>().add(LoginEventTest(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          ));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5E5BFF),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text('OR SIGN IN WITH',
                              style: TextStyle(color: Colors.grey)),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          // Implement Google sign-in logic here
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Center(

                            child: Image.asset(
                              'assets/images/Google.png',
                              width: 50,
                              height: 50,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()),
                            );
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}