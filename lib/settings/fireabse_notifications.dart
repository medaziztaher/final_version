import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink_app/api/global.dart';
import 'package:medilink_app/settings/local_notifications.dart';

class FirebaseNotification extends GetxController with WidgetsBindingObserver {
  final RxBool _isInForeground = true.obs;
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    WidgetsBinding.instance.addObserver(this);
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print("notificationtoken : $fCMToken");
    setGlobaldeviceToken(fCMToken);
    if (_isInForeground.value == true) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        _handleForegroundMessage(message);
      });
    }
    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // App is in the foreground
      _isInForeground.value = true;
      print(_isInForeground);
    } else {
      // App is in the background or inactive
      _isInForeground.value = false;
      print(_isInForeground);
    }
  }

  static Future<void> _handleBackgroundMessage(RemoteMessage message) async {
    NotificationService().showNotification(
        body: message.notification?.body,
        title: message.notification?.title,
        payload: jsonEncode(message.data));
    print('Title : ${message.notification?.title}');
    print('body : ${message.notification?.body}');
    print('Payload: ${message.data}');
  }

  void _handleForegroundMessage(RemoteMessage message) {
    NotificationService().showNotification(
      body: message.notification?.body,
      title: message.notification?.title,
      payload: jsonEncode(message.data),
    );
    print('Foreground Message - Title: ${message.notification?.title}');
    print('Foreground Message - Body: ${message.notification?.body}');
    print('Foreground Message - Payload: ${message.data}');
  }
}
