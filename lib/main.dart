
import 'package:flutter/material.dart';
import 'package:testing/core/constants/appTheme.dart';
import 'package:testing/presentation/screens/NotificationsMenu.dart';
import 'package:testing/presentation/screens/profile_menu_screen.dart';

void main() {
  appTheme().theme = "Dark";
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SSwitchTheme(),
    );
  }
}