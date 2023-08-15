import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/screens/allergie/get_allergie/get_allergie_screen.dart';
import 'package:medilink_app/screens/allergie/user_allergie/user_allergies_controller.dart';

class Body extends StatelessWidget {
  const Body({super.key, required this.user, this.userId});
  final User user;
  final String? userId;
  @override
  Widget build(BuildContext context) {
    final userAllergyController =
        Get.put(UserAllergeyController(userId: user.id));
    userAllergyController.getUserAllergy();
    return Obx(() {
      if (userAllergyController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (userAllergyController.allergies.isNotEmpty) {
        final allergies = userAllergyController.allergies;
        return ListView.builder(
          itemCount: allergies.length,
          itemBuilder: (context, index) {
            final allergy = allergies[index];
            return ListTile(
              title: Text(allergy.type),
              subtitle: Text(allergy.yearOfDiscovery.toString()),
              onTap: () {
                Get.off(() => GetAllergyScreen(allergyId: allergy.id));
              },
            );
          },
        );
      } else {
        return Center(
            child: userId == user.id
                ? const Text('You don\'t have any allergies')
                : Text('this ${user.name} don\'t have any allergies'));
      }
    });
  }
}
