import 'package:flutter/material.dart';
import 'package:testing_firebase/core/constants/PickColorHelper.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  // State variables for toggle switches
  Map<String, bool> switchStates = {
    'App Notification': true,
    'Recommended Shop': false,
    'Promotion': false,
    'Offer': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Notification Settings',
          style: TextStyle(
            color: Color(0xFF333E63),
            fontSize: 21,
            fontWeight: FontWeight.w500,
            fontFamily: 'Gilroy',
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // Settings list at the top
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: _buildNotificationToggle(
              'App Notification',
              switchStates['App Notification']!,
                  (value) {
                setState(() {
                  switchStates['App Notification'] = value;
                });
              },
            ),
          ),

          // Illustration in the middle
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/NoNotificationImage.png',
                    height: 250,
                  ),
                  SizedBox(height: 20),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationToggle(String title, bool value, Function(bool) onChanged) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      // Removed the border decoration
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 19,  // Changed font size
              fontWeight: FontWeight.w500,  // Added medium weight
              color: Color(0xFF333E63),  // Changed text color to match the app bar title
              fontFamily: 'Gilroy',  // Added Gilroy font family
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.indigo,
          ),
        ],
      ),
    );
  }
}