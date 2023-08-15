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
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {
      // Handle notification interaction here
      if (notificationResponse.payload != null) {
        // Do something based on the payload
        print('Notification payload: ${notificationResponse.payload}');
      }
    });
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max),
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
    final notificationDetail = await notificationDetails();

    for (int day = 0; day < numberOfDays; day++) {
      final scheduledNotificationDateTime = tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        now.day + day,
        notificationTime.hour,
        notificationTime.minute,
      );

      await notificationsPlugin.zonedSchedule(
        id + day, // Different ID for each day's notification
        title,
        body,
        scheduledNotificationDateTime,
        notificationDetail,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }
}
