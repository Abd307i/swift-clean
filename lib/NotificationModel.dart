import 'package:flutter/cupertino.dart';

class NotificationModel{
  IconData icon;
  String title;
  String descirption;

  NotificationModel({
    required this.icon,
    required this.title,
    required this.descirption
  });
  static List<NotificationModel> getNotification(){
   List<NotificationModel> notifications = [];
   notifications.add(NotificationModel(
       icon: CupertinoIcons.alarm,
       title: 'Late For Delivery!',
       descirption: 'You Are Late, You must go ahead!'));
   notifications.add(NotificationModel(
       icon: CupertinoIcons.alarm,
       title: 'Late For Order!',
       descirption: 'You Are Late, You must go ahead!'));
   notifications.add(NotificationModel(
       icon: CupertinoIcons.alarm,
       title: 'Hey What\'s Happend!',
       descirption: 'You Are Late, You must go ahead!'));

    return notifications;
  }
}