import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('flutter_logo');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        print('Notification received!');
        String title = notificationResponse.payload!;
        switch (title) {
          case 'Notification 1':
            // Do something for notification 1
            break;
          case 'Notification 2':
            // Do something for notification 2
            break;
          // Add more cases for other notification titles
        }
      },
    );
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
          'channelId',
          'channelName',
          importance: Importance.max,
          playSound: true,
          sound: RawResourceAndroidNotificationSound('notification'),
        ),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    return notificationsPlugin
        .show(id, title, body, await notificationDetails(), payload: payload);
  }

  Future scheduleNotification(
      {int id = 0,
      String? title,
      String? body,
      String? payLoad,
      required TimeOfDay notificationTime}) async {
    final now = tz.TZDateTime.now(tz.local);
    print(tz.local);
    final scheduledNotificationDateTime = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      notificationTime.hour,
      notificationTime.minute,
    );
    print(now);
    print(scheduledNotificationDateTime);
    return notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(
          scheduledNotificationDateTime,
          tz.local,
        ),
        await notificationDetails(),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
