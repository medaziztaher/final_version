import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink_app/screens/home/home_controller.dart';
import 'package:medilink_app/screens/home/patient/patient_screens.dart';
import 'package:medilink_app/screens/home/provider/provider_screens.dart';
import 'package:medilink_app/utils/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeData>(
        init: HomeData(),
        builder: (controller) {
          return Scaffold(
            body: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: primaryColor,
                ));
              }
              if (controller.user.role == 'Patient') {
                return const PatientScreens();
              } else {
                return const DoctorScreens();
              }
            }),
          );
        });
  }
}
