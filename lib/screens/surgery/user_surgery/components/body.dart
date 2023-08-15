import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/screens/surgery/get_surgery/get_surgerie_screen.dart';
import 'package:medilink_app/screens/surgery/user_surgery/user_surgery_controller.dart';

class Body extends StatelessWidget {
  const Body({super.key, required this.user, required this.userId});
  final User user;
  final String? userId;

  @override
  Widget build(BuildContext context) {
    final userAllergyController =
        Get.put(UserSurgerieController(userId: user.id));
    userAllergyController.getUserSurgerie();

    return Obx(() {
      if (userAllergyController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (userAllergyController.surgeries.isNotEmpty) {
        final surgeries = userAllergyController.surgeries;
        return ListView.builder(
          itemCount: surgeries.length,
          itemBuilder: (context, index) {
            final surgerie = surgeries[index];
            return ListTile(
              title: Text(surgerie.type),
              subtitle: Text(surgerie.date.toString()),
              onTap: () {
                Get.off(() => GetSurgerieScreen(surgerieId: surgerie.id));
              },
            );
          },
        );
      } else {
        return Center(
            child: userId == user.id
                ? const Text('You don\'t have any surgeries')
                : Text('this ${user.name} don\'t have any surgeries'));
      }
    });
  }
}
