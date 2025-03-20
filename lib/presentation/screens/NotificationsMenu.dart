import 'package:flutter/material.dart';
import 'package:testing/core/constants/appTheme.dart';
import 'package:testing/NotificationModel.dart';
import 'package:testing/core/constants/PickColorHelper.dart';
import 'package:testing/presentation/widgets/BuildNotificationWidget.dart';

class NotificationsMenu extends StatelessWidget {
  NotificationsMenu({super.key});

  final List<NotificationModel> notifications = [];
  void _getNotifications(){
    notifications.addAll(NotificationModel.getNotification());
  }

  @override
  Widget build(BuildContext context) {
    appTheme().theme = 'Light';
    _getNotifications();
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification',
        style: TextStyle(color: ColorPickerHelper.colorHelper('mainTextColor'))),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed:() {
          Navigator.pop(context);
        },),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
              Expanded(
                child: ListView.separated(
                    padding: EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      return buildNotificationWidget(notifications[index].icon,
                          notifications[index].title,
                          notifications[index].descirption,
                          ColorPickerHelper.colorHelper('fieldBackgroundColor'),
                          ColorPickerHelper.colorHelper('mainTextColor'),
                          ColorPickerHelper.colorHelper('secondaryTextColor'));
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 15),
                    itemCount: notifications.length
                ),
              )
        ],
      ),
    );
  }
}
