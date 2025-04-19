import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing_firebase/core/constants/PickColorHelper.dart';

import '../widgets/BuildNotificationSettingsWidget.dart';


class Notificationsettings extends StatelessWidget {
  const Notificationsettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPickerHelper.colorHelper('backgroundColor'),
      appBar: AppBar(
        backgroundColor: ColorPickerHelper.colorHelper('backgroundColor'),
        title: Text('Notification Setting',
            style: TextStyle(color: ColorPickerHelper.colorHelper('mainTextColor'))),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: ColorPickerHelper.colorHelper('mainTextColor'),),
          onPressed:() {
            Navigator.pop(context);
          },),
      ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: ListView(
                    padding:EdgeInsets.fromLTRB(0, 0, 0, 5),
                    children: [
                      notificationSettings('App Notification',true),
                      notificationSettings('Recommended Shop',true),
                      notificationSettings('Promotion',false),
                      notificationSettings('Offer',true)
                    ],
                  )
              )
            ]
        ),
    );
  }
}
