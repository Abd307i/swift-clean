import 'package:flutter/material.dart';
import 'package:testing_firebase/core/constants/appTheme.dart';
import 'package:testing_firebase/core/constants/PickColorHelper.dart';
import 'package:testing_firebase/features/auth/presentation/pages/sign_in_screen.dart';
import 'package:testing_firebase/features/notification/presentation/pages/NotificationsScreen.dart';
import 'package:testing_firebase/features/order%20history/presentation/pages/OrderHistoryScreen.dart';
import 'package:testing_firebase/features/profile/domain/entities/profile_entity.dart';
import 'package:testing_firebase/features/profile/presentation/pages/HelpCenterScreen.dart';
import 'package:testing_firebase/features/profile/presentation/pages/InviteFriendsScreen.dart';
import 'package:testing_firebase/features/profile/presentation/widgets/BuildMenuItemsWidget.dart';
import 'package:testing_firebase/features/profile/presentation/widgets/BuildSignOutWidget.dart';
import 'package:testing_firebase/features/profile/presentation/pages/edit_profile_screen.dart'; // Added import for EditProfileScreen

class SSwitchTheme extends StatefulWidget{
  const SSwitchTheme({super.key});

  @override
  ProfileScreen createState() => ProfileScreen();
}

class ProfileScreen extends State<SSwitchTheme> {
  // Mock user profile data - replace with actual user data from your auth system
  final user = ProfileEntity(
      userId: "user123",
      firstName: "Ali",
      lastName: "Dweik",
      phone: "",
      imgUrl: "",
      address: "Los Angeles, United States"
  );

  @override
  Widget build(BuildContext context) {
    appTheme().theme = 'Light';
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Profile',style: TextStyle(color: ColorPickerHelper.colorHelper('mainTextColor'))),
        leading: Switch(
            value: (appTheme().theme == 'Light' ? false : true),
            onChanged: (value) {
              setState(() {
                appTheme().theme = (appTheme().theme == 'Light'?'Dark':'Light');
              });
            }),
        actions: [
          // Added edit icon button
          IconButton(
            icon: Icon(Icons.edit, color: ColorPickerHelper.colorHelper('mainTextColor')),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfileScreen(user: user),
                ),
              );
            },
          ),
        ],
        backgroundColor: ColorPickerHelper.colorHelper('backgroundColor'),
      ),
      backgroundColor: ColorPickerHelper.colorHelper('backgroundColor'),

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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // User Information Section
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.blue,
                        child: Text(
                          'A',
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Ali Dweik',
                            style: TextStyle(
                              color: ColorPickerHelper.colorHelper('mainTextColor'),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Los Angeles, United States',
                            style: TextStyle(
                              fontSize: 16,
                              color: ColorPickerHelper.colorHelper('secondaryTextColor'),
                            ),
                          ),
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
                            MaterialPageRoute(builder: (context) => NotificationsMenu()) ,
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
                              MaterialPageRoute(builder: (context) => OrderHistoryScreen()));
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
          ),
        ],
      ),
    );
  }
}