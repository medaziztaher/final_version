import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink_app/screens/home/home_controller.dart';
import 'package:medilink_app/screens/profile/healthcare_provider_profile/profile_screen.dart';
import 'package:medilink_app/screens/profile/patient/patient_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    HomeData controller = Get.put(HomeData());
    return Scaffold(
      body: controller.user.role == 'Patient'
          ? const PatientProfile()
          : const HealthcareProviderProfileScreen(),
    );
  }
}
