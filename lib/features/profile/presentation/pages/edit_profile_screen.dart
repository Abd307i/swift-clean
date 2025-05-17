import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_firebase/features/profile/presentation/pages/ProfileMenuScreen.dart';

import '../../domain/entities/profile_entity.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
/*
class EditProfileTest extends StatefulWidget{
  final ProfileEntity user;
  const EditProfileTest({Key? key, required this.user}) : super(key: key);

  @override
  State<EditProfileTest> createState() => _EditProfileScreen(user);
}


class _EditProfileScreen extends State<EditProfileTest> {
  final ProfileEntity user;
  _EditProfileScreen(this.user);
  //const _EditProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ProfileBloc,ProfileState>(

        listener: (context,state){
          if(state is ProfileError){
            AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.topSlide,
              title: 'Error',
              desc: state.message,
            ).show();
          }
          if(state is ProfileUpdated || state is ProfileImageDeleted || state is ProfileImageUpdated){
            AwesomeDialog(
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.topSlide,
              title: 'Success',
              btnOkOnPress: () => {
                /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen(user)),
                )*/
              },
              desc: 'Profile Updated Successfully',
            ).show();
          }
          if(state is ProfileLoaded){
            AwesomeDialog(
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.topSlide,
              title: 'Success',
              btnOkOnPress: () => {
                /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen(user)),
                )*/
              },
              desc: 'Profile Loaded Successfully',
            ).show();
          }
        },
        builder: (context,state){
          /*if(state is ProfileLoading){
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }*/
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        },
    );
    /*<ProfileBloc, ProfileState>(
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
    );*/
  }

  /*void _updateProfile(BuildContext context, {String? firstName}) {
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
  }*/
}*/

class EditProfileScreen extends StatelessWidget {
  final String userId;
  const EditProfileScreen({super.key, required this.userId});

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
              //ImagePickerDialog(imageUrl: profile.imgUrl),
              const SizedBox(height: 20),
              /*EditableTextField(
                initialValue: profile.name,
                label: 'Name',
                onSaved: (newName) => _updateProfile(context, name: newName),
              ),*/
              // Add more editable fields...
            ],
          ),
        ),
      ),
    );
  }

  /*void _updateProfile(BuildContext context, {String? name}) {
    context.read<ProfileBloc>().add(
      UpdateProfileEvent(
        profile.copyWith(name: name),
      ),
    );
  }*/
}