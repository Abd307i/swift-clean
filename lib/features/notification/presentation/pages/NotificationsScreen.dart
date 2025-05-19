import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_firebase/core/constants/PickColorHelper.dart';
import 'package:testing_firebase/features/notification/domain/usecases/get_notifications.dart';
import 'package:testing_firebase/features/notification/domain/usecases/mark_as_read.dart';
import 'package:testing_firebase/features/notification/domain/usecases/toggle_mute_notifications.dart';
import 'package:testing_firebase/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:testing_firebase/features/notification/presentation/bloc/notification_event.dart';
import 'package:testing_firebase/features/notification/presentation/bloc/notification_state.dart';
import 'package:testing_firebase/features/notification/presentation/widgets/BuildNotificationWidget.dart';

import '../../dependency_injection.dart' as di;
import 'NotificationSettingsScreen.dart';

class NotificationPage extends StatelessWidget{
  final String userId;

  const NotificationPage(this.userId);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) =>
        NotificationBloc(
          getNotifications: di.sl<GetNotifications>(),
          getStreamNotifications: di.sl<GetStreamNotifications>())..add(GetStreamNotificationsEvent(userId))
          //markAsRead: di.sl<MarkAsRead>(),
          //toggleMuteNotification: di.sl<ToggleMuteNotification>())..add(GetNotificationsEvent(userId))
      ,child:
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Notifications',style: TextStyle(color: ColorPickerHelper.colorHelper('mainTextColor'))),
            leading: IconButton(onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back), color: ColorPickerHelper.colorHelper('mainTextColor'),),
            actions: [
              IconButton(
                icon: Icon(Icons.settings, color: ColorPickerHelper.colorHelper('mainTextColor')),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationSettingsScreen(userId: userId),
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
    int count = 0;
    return BlocConsumer<NotificationBloc,NotificationState>(
      listener: (context, state) {
        if(state is NotificationError){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
        if(state is NewNotificationArrived){
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.topSlide,
            title: 'ff',
            desc: 'ss',
          ).show();
        }
      },
      builder: (context, state) {
        if(state is StreamNotificationsLoading){
          return const Center(child: CircularProgressIndicator());
        }else if(state is StreamNotificationsLoaded){
            return StreamBuilder(
                stream: state.notifications,
                builder: (context, snapshot){
                  final notifications = snapshot.data!;
                  if(notifications.isEmpty){
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:[
                        Center(
                            child: Column(
                                children: [
                                  SizedBox(height: 150.0),
                                  Image.asset('assets/NoNotificationImage.png'),
                                  SizedBox(height: 20.0),
                                  Text('No Notification Here!',
                                    style: TextStyle(color: ColorPickerHelper.colorHelper('secondaryTextColor'),
                                        fontSize: 22.0),
                                  )
                                ]
                            )
                        )
                      ],
                    );
                  }else{
                    return ListView.builder(itemCount: notifications.length,
                        itemBuilder:(context, index) {
                          return buildNotificationWidget(
                              Icons.access_alarm,
                              notifications[index].title,
                              notifications[index].body,
                              ColorPickerHelper.colorHelper('fieldBackgroundColor'),
                              ColorPickerHelper.colorHelper('mainTextColor'),
                              ColorPickerHelper.colorHelper('secondaryTextColor')
                          );
                        }
                    );
                  }
                }
            );

        }else{
          return const Center(child: Text('Try Again Later'));
        }
      },
    );
  }
}