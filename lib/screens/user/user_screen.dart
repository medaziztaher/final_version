import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink_app/screens/user/componnets/doctor/doctor_screen.dart';
import 'package:medilink_app/screens/user/componnets/patient/patient_screen.dart';
import 'package:medilink_app/screens/user/componnets/provider/provider_screen.dart';
import 'package:medilink_app/screens/user/user_screen_controller.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key, required this.userId}) : super(key: key);
  final String userId;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserData>(
        init: UserData(userId: userId),
        builder: (controller) {
          return Scaffold(body: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (controller.user.role == 'Patient') {
              return PatientScreen(user: controller.user);
            } else if (controller.user.type == 'Doctor') {
              return DoctorScreen(user: controller.user);
            } else {
              return ProviderScreen(user: controller.user);
            }
          }));
        });
  }
}
