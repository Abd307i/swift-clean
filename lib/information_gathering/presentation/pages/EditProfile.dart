import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_firebase/information_gathering/presentation/bloc/edit_profile_bloc.dart';
import 'package:testing_firebase/information_gathering/presentation/bloc/edit_profile_event.dart';
import 'package:testing_firebase/information_gathering/presentation/bloc/edit_profile_state.dart';
import 'package:testing_firebase/information_gathering/presentation/widgets/custom_app_bar.dart';
import 'package:testing_firebase/information_gathering/presentation/widgets/custom_text_field.dart';
import 'package:testing_firebase/information_gathering/presentation/widgets/primary_button.dart';
import 'package:testing_firebase/information_gathering/presentation/widgets/section_title.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Load user profile when the page is initialized
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      context.read<EditProfileBloc>().add(LoadUserProfile(userId: userId));
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _updateControllers(EditProfileState state) {
    // Only update controllers if they're empty and state has data
    if (_firstNameController.text.isEmpty && state.firstName.isNotEmpty) {
      _firstNameController.text = state.firstName;
    }
    if (_lastNameController.text.isEmpty && state.lastName.isNotEmpty) {
      _lastNameController.text = state.lastName;
    }
    if (_phoneController.text.isEmpty && state.phoneNumber.isNotEmpty) {
      _phoneController.text = state.phoneNumber;
    }
    if (_addressController.text.isEmpty && state.address.isNotEmpty) {
      _addressController.text = state.address;
    }
    // Email is from Firebase Auth and is read-only
    if (_emailController.text.isEmpty && state.userDetails?.email != null) {
      _emailController.text = state.userDetails!.email!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Edit Profile',
      ),
      body: BlocConsumer<EditProfileBloc, EditProfileState>(
        listener: (context, state) {
          // Show error message if any
          if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }

          // Show success message and navigate back
          if (state.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Profile updated successfully'),
                backgroundColor: Colors.green,
              ),
            );
            // Navigate back after successful update
            Navigator.of(context).pop();
          }

          // Update text controllers with user data
          _updateControllers(state);
        },
        builder: (context, state) {
          if (state.isLoading && state.userDetails == null) {
            // Show loading indicator while initially loading profile
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Profile picture
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.person,
                              size: 80,
                              color: Colors.white,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: const Color(0xFF5D5FEF),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // First Name
                    const SectionTitle(title: 'First Name'),
                    CustomTextField(
                      controller: _firstNameController,
                      labelText: 'First Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Last Name
                    const SectionTitle(title: 'Last Name'),
                    CustomTextField(
                      controller: _lastNameController,
                      labelText: 'Last Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Email (read-only)
                    const SectionTitle(title: 'Email'),
                    CustomTextField(
                      controller: _emailController,
                      labelText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      validator: null, // Email is read-only from Firebase Auth
                    ),

                    const SizedBox(height: 16),

                    // Phone Number
                    const SectionTitle(title: 'Phone Number'),
                    CustomTextField(
                      controller: _phoneController,
                      labelText: 'Phone Number',
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Address
                    const SectionTitle(title: 'Address'),
                    CustomTextField(
                      controller: _addressController,
                      labelText: 'Address',
                      isMultiline: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 32),

                    // Save Button
                    PrimaryButton(
                      text: 'Save Changes',
                      isLoading: state.isLoading,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Update bloc with new values
                          final bloc = context.read<EditProfileBloc>();
                          bloc.add(UpdateFirstName(firstName: _firstNameController.text));
                          bloc.add(UpdateLastName(lastName: _lastNameController.text));
                          bloc.add(UpdatePhoneNumber(phoneNumber: _phoneController.text));
                          bloc.add(UpdateAddress(address: _addressController.text));

                          // Save profile
                          bloc.add(const SaveProfile());
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}