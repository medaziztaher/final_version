import 'dart:convert';

import 'package:get/get.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/models/notification.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/settings/networkhandler.dart';

class NotificationsController extends GetxController {
  final RxList<Notifications> notifications = <Notifications>[].obs;
  final RxList<User> sender = <User>[].obs;
  User user;
  RxBool isLoading = false.obs;
  NetworkHandler networkHandler = NetworkHandler();

  NotificationsController({required this.user});

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() async {
    await getUserNotifications();
  }

  Future<void> getSenders() async {}

  Future<void> getUserNotifications() async {
    isLoading.value = true;
    try {
      final response = await networkHandler.get(notificationUri);
      print("response statuscode : ${response.statusCode}");
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'] as List<dynamic>;
        print(data);
        final notificationList = data
            .map((item) => Notifications.fromJson(item))
            .toList(growable: false);
        notifications.value = notificationList;
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
