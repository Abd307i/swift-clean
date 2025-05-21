import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_firebase/core/constants/PickColorHelper.dart';
import 'package:testing_firebase/features/notification/data/models/notification_model.dart';
import 'package:testing_firebase/features/notification/domain/entities/notification_entity.dart';
import 'package:testing_firebase/features/notification/domain/usecases/get_notifications.dart';
import 'package:testing_firebase/features/notification/domain/usecases/mark_as_read.dart';
import 'package:testing_firebase/features/notification/domain/usecases/toggle_mute_notifications.dart';
import 'package:testing_firebase/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:testing_firebase/features/notification/presentation/bloc/notification_event.dart';
import 'package:testing_firebase/features/notification/presentation/bloc/notification_state.dart';
import 'package:testing_firebase/features/notification/presentation/bloc/notification_state_uni.dart';
import 'package:testing_firebase/features/notification/presentation/widgets/BuildNotificationWidget.dart';

import '../../dependency_injection.dart' as di;
import 'NotificationSettingsScreen.dart';

class NotificationPage extends StatelessWidget {
  final String userId;

  const NotificationPage(this.userId);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotificationBloc>(
      create:
          (_) => di.sl(),
      //markAsRead: di.sl<MarkAsRead>(),
      //toggleMuteNotification: di.sl<ToggleMuteNotification>())..add(GetNotificationsEvent(userId))
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Notifications',
            style: TextStyle(
              color: ColorPickerHelper.colorHelper('mainTextColor'),
            ),
          ),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back),
            color: ColorPickerHelper.colorHelper('mainTextColor'),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.settings,
                color: ColorPickerHelper.colorHelper('mainTextColor'),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => NotificationSettingsScreen(userId: userId),
                  ),
                );
              },
            ),
          ],
          backgroundColor: ColorPickerHelper.colorHelper('backgroundColor'),
        ),
        body: NotificationsMenu(userId: userId),
        backgroundColor: ColorPickerHelper.colorHelper('backgroundColor'),
      ),
    );
  }
}

class NotificationsMenu extends StatelessWidget {
  final String userId;

  NotificationsMenu({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {

    /*return BlocConsumer<NotificationBloc, UniNotificationState>(
      listener: (context, state) {
        if (state.error?.isNotEmpty == true) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error!)));
          context.read<NotificationBloc>().add(ConsumeError());
        }
      },
      builder: (context, state) {
        if (state.isLoading == true) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.notifications?.isNotEmpty == true) {
          return ListView.builder(
            itemCount: state.notifications!.length,
            itemBuilder: (context, index) {
              return buildNotificationWidget(
                Icons.access_alarm,
                state.notifications![index].title,
                state.notifications![index].body,
                ColorPickerHelper.colorHelper('fieldBackgroundColor'),
                ColorPickerHelper.colorHelper('mainTextColor'),
                ColorPickerHelper.colorHelper('secondaryTextColor'),
              );
            },
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 150.0),
                    Image.asset('assets/NoNotificationImage.png'),
                    SizedBox(height: 20.0),
                    Text(
                      'No Notification Here!',
                      style: TextStyle(
                        color: ColorPickerHelper.colorHelper(
                          'secondaryTextColor',
                        ),
                        fontSize: 22.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );*/
    return NotificationsStream(context.read<NotificationBloc>().getStream(userId));
  }
}

class NotificationsStream extends StatelessWidget {

  Stream<QuerySnapshot> s;

  NotificationsStream(this.s);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: s,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final notifications = snapshot.data!.docs;
        List<NotificationEntity> notificationsList = [];
        List<Widget> views = [];
        for (var notification in notifications) {
          final n= NotificationEntity(
              id: notification.get("id"),
              title: notification.get("title"),
              body:notification.get("body"),
              type: notification.get("type"));
          notificationsList.add(n
              );
          views.add(getWidgetForNotification(n));
        }
        return Expanded(
          child: ListView(
            reverse: false,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: views,
          ),
        );
      },
    );
  }

  Widget getWidgetForNotification(NotificationEntity e){
    return buildNotificationWidget(
      Icons.access_alarm,
      e.title,
      e.body,
      ColorPickerHelper.colorHelper('fieldBackgroundColor'),
      ColorPickerHelper.colorHelper('mainTextColor'),
      ColorPickerHelper.colorHelper('secondaryTextColor'),
    );

  }
}
