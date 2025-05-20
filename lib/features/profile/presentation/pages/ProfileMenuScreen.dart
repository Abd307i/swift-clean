import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_firebase/core/constants/appTheme.dart';
import 'package:testing_firebase/core/constants/PickColorHelper.dart';
import 'package:testing_firebase/features/auth/presentation/pages/sign_in_screen.dart';
import 'package:testing_firebase/features/notification/presentation/pages/NotificationsScreen.dart';
import 'package:testing_firebase/features/order%20history/presentation/pages/OrderHistoryScreen.dart';
import 'package:testing_firebase/features/profile/domain/entities/profile_entity.dart';
import 'package:testing_firebase/features/profile/domain/usecases/get_profile_data.dart';
import 'package:testing_firebase/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:testing_firebase/features/profile/presentation/bloc/profile_event.dart';
import 'package:testing_firebase/features/profile/presentation/pages/HelpCenterScreen.dart';
import 'package:testing_firebase/features/profile/presentation/pages/InviteFriendsScreen.dart';
import 'package:testing_firebase/features/profile/presentation/widgets/BuildMenuItemsWidget.dart';
import 'package:testing_firebase/features/profile/presentation/widgets/BuildSignOutWidget.dart';
import 'package:testing_firebase/features/profile/presentation/pages/edit_profile_screen.dart';
import 'package:testing_firebase/features/services/presentation/pages/service_page.dart';

import '../../dependency_injection.dart' as di;

import '../bloc/profile_state.dart'; // Added import for EditProfileScreen

class ProfilePage extends StatelessWidget{
  final String userId;

  const ProfilePage(this.userId);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(
        loadProfileData:di.sl<LoadProfileData>())..add(LoadProfileEvent(userId)),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Profile',style: TextStyle(color: ColorPickerHelper.colorHelper('mainTextColor'))),
          actions: [
            IconButton(
              icon: Icon(Icons.edit, color: ColorPickerHelper.colorHelper('mainTextColor')),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfileScreen(userId: userId),
                  ),
                );
              },
            ),
          ],
          backgroundColor: ColorPickerHelper.colorHelper('backgroundColor'),
        ),
        body: ProfileScreen(userId: userId,),
        backgroundColor: ColorPickerHelper.colorHelper('backgroundColor'),

      ),
    );
  }
}
class ProfileScreen extends StatelessWidget {
  // Mock user profile data - replace with actual user data from your auth system
  final String userId;

  const ProfileScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        else if (state is ProfileLoaded) {
          return ListView(
                    children: [
                    Container(
                    alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        color: ColorPickerHelper.colorHelper('fieldBackgroundColor'),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                  ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //  User Information Section
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.blue,
                          child: Text(
                            state.profile.firstName[0],
                           style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              (state.profile.firstName+' '+state.profile.lastName).toString(),
                              style: TextStyle(
                                color: ColorPickerHelper.colorHelper('mainTextColor'),
                               fontSize: 20,
                              fontWeight: FontWeight.bold,
                              ),
                            ),
                            /*Text(
                              'Los Angeles, United States',
                              style: TextStyle(
                                fontSize: 16,
                                color: ColorPickerHelper.colorHelper('secondaryTextColor'),
                              ),
                            ),*/
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 20),
                    Column(
                      // Menu Items
                      children: [
                        GestureDetector(
                          onDoubleTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => NotificationPage(userId,)) ,
                            );
                          },
                          child: buildMenuItem(
                              Icons.notifications, 'Notification',ColorPickerHelper.colorHelper('fieldBackgroundColor')
                              ,ColorPickerHelper.colorHelper('mainTextColor')),
                        ),
                        buildMenuItem(
                            Icons.payment, 'Payment Method',ColorPickerHelper.colorHelper('fieldBackgroundColor')
                           ,ColorPickerHelper.colorHelper('mainTextColor')),
                        GestureDetector(
                          onDoubleTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => OrderHistoryScreen(userId: userId,)));
                          },
                          child: buildMenuItem(
                              Icons.history, 'Order History',ColorPickerHelper.colorHelper('fieldBackgroundColor')
                              ,ColorPickerHelper.colorHelper('mainTextColor')),
                        ),
                        buildMenuItem(
                            Icons.location_on, 'Delivery Address',ColorPickerHelper.colorHelper('fieldBackgroundColor')
                            ,ColorPickerHelper.colorHelper('mainTextColor')),
                        buildMenuItem(
                            Icons.local_offer, 'Offer',ColorPickerHelper.colorHelper('fieldBackgroundColor')
                            ,ColorPickerHelper.colorHelper('mainTextColor')),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => InviteFriendsScreen()),
                            );
                        },
                          child: buildMenuItem(
                              Icons.group_add, 'Invite Friends',ColorPickerHelper.colorHelper('fieldBackgroundColor')
                              ,ColorPickerHelper.colorHelper('mainTextColor')),
                        ),
                        GestureDetector(
                          onDoubleTap:(){
                            Navigator.push(
                                context,
                               MaterialPageRoute(builder: (context) => HelpCenterScreen()));
                          },
                          child: buildMenuItem(
                              Icons.help, 'Help Center',ColorPickerHelper.colorHelper('fieldBackgroundColor')
                              ,ColorPickerHelper.colorHelper('mainTextColor')),
                        ),
                        buildMenuItem(
                            Icons.info, 'About Us',ColorPickerHelper.colorHelper('fieldBackgroundColor')
                            ,ColorPickerHelper.colorHelper('mainTextColor')),
                        GestureDetector(
                          onDoubleTap:(){
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ServicesPage(userId: userId,)));
                          },
                          child: buildMenuItem(
                              Icons.help, 'Services',ColorPickerHelper.colorHelper('fieldBackgroundColor')
                              ,ColorPickerHelper.colorHelper('mainTextColor')),
                        )
                      ],

                    ),
                    SizedBox(height: 20),

                    GestureDetector(
                      onDoubleTap:(){
                          Navigator.push(
                           context,
                            MaterialPageRoute(builder: (context) => SignInScreen()));
                      },
                      child: buildSignOutItem(Icons.exit_to_app, 'Sign Out'),
                    ),


                  // Sign Out Button
                  ],
                ),
              ),
              )
            ],
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
  /*
      body: ListView(
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              color: ColorPickerHelper.colorHelper('fieldBackgroundColor'),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
              ),
            ),

          ),
        ],
      ),
    );
  }
}*/