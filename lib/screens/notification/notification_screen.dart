import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink_app/screens/home/home_controller.dart';
import 'package:medilink_app/screens/notification/components/body.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeData homeController = Get.put(HomeData());
    return Scaffold(
      body: Body(user: homeController.user),
    );
  }
}
