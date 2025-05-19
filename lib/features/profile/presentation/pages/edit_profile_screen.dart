// FILE 4: edit_profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:testing_firebase/core/widgets/custom_button.dart';
import 'package:testing_firebase/core/widgets/custom_text_field.dart';
import 'package:testing_firebase/features/profile/domain/entities/profile_entity.dart';
import 'package:testing_firebase/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:testing_firebase/features/profile/presentation/bloc/profile_event.dart';
import 'package:testing_firebase/features/profile/presentation/bloc/profile_state.dart';
import 'package:testing_firebase/features/profile/data/models/profile_model.dart';
import 'package:testing_firebase/features/profile/domain/usecases/get_profile_data.dart';
import 'package:testing_firebase/features/profile/domain/usecases/update_profile_data.dart';
import 'package:testing_firebase/features/profile/domain/usecases/delete_profile_image.dart';
import 'package:testing_firebase/features/profile/domain/usecases/upload_profile_image.dart';
import '../../dependency_injection.dart' as di;

class EditProfileScreen extends StatefulWidget {
  final String userId;
  const EditProfileScreen({super.key, required this.userId});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  ProfileEntity? _currentProfile;
  bool _isLoading = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _populateFields(ProfileEntity profile) {
    _currentProfile = profile;
    _firstNameController.text = profile.firstName;
    _lastNameController.text = profile.lastName;
    _phoneController.text = profile.phone;
    _emailController.text = profile.email;
    _addressController.text = profile.address ?? '';
  }

  void _updateProfile() {
    if (_currentProfile == null) return;

    setState(() {
      _isLoading = true;
    });

    final updatedProfile = ProfileModel(
      userId: _currentProfile!.userId,
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      phone: _phoneController.text,
      email: _emailController.text,
      imgUrl: _currentProfile!.imgUrl,
      address: _addressController.text.isNotEmpty ? _addressController.text : null,
    );

    context.read<ProfileBloc>().add(UpdateProfileEvent(updatedProfile));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(
        loadProfileData: di.sl<LoadProfileData>(),
        updateProfileData: di.sl<UpdateProfileData>(),
        deleteProfileImage: di.sl<DeleteProfileImage>(),
        uploadProfileImage: di.sl<UploadProfileImage>(),
      )..add(LoadProfileEvent(widget.userId)),
      child: _EditProfileScreenContent(
        firstNameController: _firstNameController,
        lastNameController: _lastNameController,
        emailController: _emailController,
        phoneController: _phoneController,
        addressController: _addressController,
        isLoading: _isLoading,
        onProfileLoaded: _populateFields,
        onUpdateProfile: _updateProfile,
        onUpdateComplete: () {
          setState(() {
            _isLoading = false;
          });
        },
      ),
    );
  }
}

class _EditProfileScreenContent extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController addressController;
  final bool isLoading;
  final Function(ProfileEntity) onProfileLoaded;
  final VoidCallback onUpdateProfile;
  final VoidCallback onUpdateComplete;

  const _EditProfileScreenContent({
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.phoneController,
    required this.addressController,
    required this.isLoading,
    required this.onProfileLoaded,
    required this.onUpdateProfile,
    required this.onUpdateComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileError) {
            onUpdateComplete();
            AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.topSlide,
              title: 'Error',
              desc: state.message,
              btnOkOnPress: () {},
            ).show();
          } else if (state is ProfileUpdated) {
            onUpdateComplete();
            AwesomeDialog(
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.topSlide,
              title: 'Success',
              desc: 'Profile Updated Successfully',
              btnOkOnPress: () {
                Navigator.pop(context);
              },
            ).show();
          } else if (state is ProfileLoaded) {
            onProfileLoaded(state.profile);
          }
        },
        builder: (context, state) {
          if ((state is ProfileInitial || state is ProfileLoading) && firstNameController.text.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile Image (not functional as per requirement)
                const SizedBox(height: 20),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue.shade100,
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 60,
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
                            shape: BoxShape.circle,
                            color: Colors.blue.shade400,
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // Form Fields
                CustomTextField(
                  controller: firstNameController,
                  hintText: 'First Name',
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  controller: lastNameController,
                  hintText: 'Last Name',
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  controller: emailController,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  controller: phoneController,
                  hintText: 'Phone Number',
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  controller: addressController,
                  hintText: 'Address',
                ),
                const SizedBox(height: 40),

                // Save Button
                CustomButton(
                  text: 'Save Changes',
                  onPressed: onUpdateProfile,
                  isLoading: isLoading,
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}