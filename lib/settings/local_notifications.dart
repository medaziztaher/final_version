import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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

  Future scheduleDailyNotifications({
    int id = 0,
    String? title,
    String? body,
    String? payLoad,
    required TimeOfDay notificationTime,
    required int numberOfDays,
  }) async {
    final now = tz.TZDateTime.now(tz.local);
    for (int i = 0; i < numberOfDays; i++) {
      final scheduledNotificationDateTime = tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        now.day + i,
        notificationTime.hour,
        notificationTime.minute,
      );
      final localScheduledDateTime = DateTime.now().isUtc
          ? scheduledNotificationDateTime.add(DateTime.now().timeZoneOffset)
          : scheduledNotificationDateTime
              .subtract(DateTime.now().timeZoneOffset);

      print("tz.TZDateTime.now(tz.local) : $now");
      print(tz.local);
      print("localScheduledDateTimev: $localScheduledDateTime");

      if (localScheduledDateTime.isBefore(now)) {
        // Skip scheduling if the scheduled time is before the current time
        continue;
      }

      await notificationsPlugin.zonedSchedule(
        id + i,
        title,
        body,
        tz.TZDateTime.from(
          localScheduledDateTime,
          tz.local,
        ),
        await notificationDetails(),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }
}
