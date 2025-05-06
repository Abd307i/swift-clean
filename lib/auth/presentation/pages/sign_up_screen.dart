import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_firebase/auth/presentation%20test/bloc/auth_bloc_test.dart';
import 'package:testing_firebase/auth/presentation%20test/bloc/auth_event_test.dart';
import 'package:testing_firebase/auth/presentation%20test/bloc/auth_state_test.dart';
import 'package:testing_firebase/auth/presentation/bloc/auth_bloc.dart';
import 'package:testing_firebase/auth/presentation/bloc/auth_event.dart';
import 'package:testing_firebase/auth/presentation/bloc/auth_state.dart';
import 'package:testing_firebase/auth/presentation/pages/sign_in_screen.dart.dart' show SignInScreen;
import 'package:testing_firebase/auth/presentation/widgets/auth_text_field.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/sign-up';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBlocTest, AuthStateTest>(
      listener: (context, state) {
        if (state is RegistrationSuccessTest) {
          context.read<AuthBlocTest>().add(SendVerificationEmailEventTest());
          AwesomeDialog(
            context: context,
            dialogType: DialogType.info,
            animType: AnimType.topSlide,
            title: 'Alert',
            desc: state.message,
          ).show();
        }

        if (state is AuthErrorTest) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.topSlide,
            title: 'Error',
            desc: state.message,
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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 30),
                      const Text(
                        'Create An Account',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E4053),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Sign Up with us to get your services from anywhere. This process take only 2 minutes.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 40),

                      AuthTextField(
                        controller: _firstNameController,
                        hintText: 'First Name',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'First name is required';
                          }
                          return null;
                        },
                      ),

                      /*TextFormField(
                        controller: _firstNameController,
                        decoration: InputDecoration(
                          hintText: 'Full Name',
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
                            return 'Full name is required';
                          }
                          return null;
                        },
                      ),*/

                      const SizedBox(height: 16),

                      AuthTextField(
                        controller: _lastNameController,
                        hintText: 'Last Name',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Last name is required';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      AuthTextField(
                        controller: _emailController,
                        hintText: 'Email',
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

                      /*TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Email Address',
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
                      ),*/

                      const SizedBox(height: 16),

                      AuthTextField(
                        controller: _passwordController,
                        hintText: 'Password',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                          if (value.length < 6) {
                            return 'Password must be 6+ characters';
                          }
                          return null;
                        },
                      ),

                      /*TextFormField(
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
                          if (value.length < 6) {
                            return 'Password must be 6+ characters';
                          }
                          return null;
                        },
                      ),*/

                      const SizedBox(height: 16),

                      AuthTextField(
                        controller: _confirmPasswordController,
                        hintText: 'Confirm Password',
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),

                      /*TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Confirm Password',
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
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),*/

                      const SizedBox(height: 16),

                      AuthTextField(
                        controller: _phoneNumberController,
                        hintText: 'Phone Number',
                        validator: (value) {
                          if (value.toString().length != 10) {
                            return 'Phone Number Must Be 10 Digits Start with 07 xxxx xxxx';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 30),

                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthBlocTest>().add(
                              RegisterEventTest(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                                firstName: _firstNameController.text.trim(),
                                lastName: _lastNameController.text.trim(),
                                phoneNumber: _phoneNumberController.text.trim(),
                              )
                            );
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
                          'Sign Up',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Row(
                        children: [
                          Expanded(child: Divider()),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text('OR SIGN UP WITH',
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
                            // Implement Google sign-up logic here
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
                                width: 25,
                                height: 25,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account?"),
                          TextButton(
                            onPressed: () {
                          Navigator.push(
                              context,MaterialPageRoute(builder: (context) =>
                              SignInScreen())
                                            );
                            },
                            child: const Text(
                              'Sign In',
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
          ),
        );
      },
    );
  }
}