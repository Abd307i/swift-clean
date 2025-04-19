import 'package:flutter/material.dart';
import 'package:testing_firebase/NotificationModel.dart';
import 'package:testing_firebase/core/constants/PickColorHelper.dart';
import 'package:testing_firebase/presentation/widgets/BuildNotificationWidget.dart';

import 'NotificationSettingsScreen.dart';

class NotificationsMenu extends StatelessWidget {
  NotificationsMenu({super.key});

  final List<NotificationModel> notifications = [];
  void _getNotifications(){
    notifications.addAll(NotificationModel.getNotification());
  }

  @override
  Widget build(BuildContext context) {
    //appTheme().theme = 'Light';
    _getNotifications();
    if(notifications.isEmpty){
      return Scaffold(
        appBar: AppBar(
          title: Text('Notification',
              style: TextStyle(color: ColorPickerHelper.colorHelper('mainTextColor'))),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded, color: ColorPickerHelper.colorHelper('mainTextColor')),
            onPressed:() {
              Navigator.pop(context);
            },),
          actions: [
            IconButton(onPressed:() {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Notificationsettings()
                  )
              );
            },icon: Icon(Icons.settings,color: ColorPickerHelper.colorHelper('mainTextColor'),))
          ],
          backgroundColor: ColorPickerHelper.colorHelper('backgroundColor'),
        ),
        body: Center(
          child:Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children:[
                SizedBox(height: 150.0),
                Image.asset('assets/NoNotificationImage.png'),
                SizedBox(height: 20.0),
                Text('No Notification Here!',
                style: TextStyle(color: ColorPickerHelper.colorHelper('secondaryTextColor'),
                fontSize: 22.0),)
          ],
          )
        ),
          backgroundColor: ColorPickerHelper.colorHelper('backgroundColor')
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPickerHelper.colorHelper('backgroundColor'),
        title: Text('Notification',
        style: TextStyle(color: ColorPickerHelper.colorHelper('mainTextColor'))),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: ColorPickerHelper.colorHelper('mainTextColor')),
          onPressed:() {
          Navigator.pop(context);
        },),
        actions: [
          IconButton(onPressed:() {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Notificationsettings()
                )
            );
          },icon: Icon(Icons.settings,color: ColorPickerHelper.colorHelper('mainTextColor')))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
              Expanded(
                child: ListView.builder(
                    //padding: EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      return buildNotificationWidget(notifications[index].icon,
                          notifications[index].title,
                          notifications[index].descirption,
                          ColorPickerHelper.colorHelper('fieldBackgroundColor'),
                          ColorPickerHelper.colorHelper('mainTextColor'),
                          ColorPickerHelper.colorHelper('secondaryTextColor'));
                    },
                    itemCount: notifications.length
                ),
              )
        ],
      ),backgroundColor: ColorPickerHelper.colorHelper('backgroundColor'),
    );
  }
}
