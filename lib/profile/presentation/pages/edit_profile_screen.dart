import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/profile_entity.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';

class EditProfileScreen extends StatelessWidget {
  final ProfileEntity user;
  const EditProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdated) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Edit Profile')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              //ImagePickerDialog(imageUrl: user.imgUrl),
              const SizedBox(height: 20),
              /*EditableTextField(
                initialValue: user.firstName+' '+user.lastName,
                label: 'Name',
                onSaved: (newName) => _updateProfile(context, firstName: newName),
              ),*/
              // Add more editable fields...
            ],
          ),
        ),
      ),
    );
  }

  void _updateProfile(BuildContext context, {String? firstName}) {
    context.read<ProfileBloc>().add(
      UpdateProfileEvent(ProfileEntity(
        userId: user.userId,
        firstName: user.firstName,
        lastName: user.lastName,
        phone: user.phone,
        imgUrl: user.imgUrl,
        address: user.address
      )),
    );
  }
}