import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink_app/screens/surgery/get_surgery/components/body.dart';
import 'package:medilink_app/screens/surgery/get_surgery/get_sergerie_controller.dart';

class GetSurgerieScreen extends StatelessWidget {
  const GetSurgerieScreen({super.key, required this.surgerieId});
  final String surgerieId;

  @override
  Widget build(BuildContext context) {
    print(surgerieId);
    return GetBuilder<GetSurgerieController>(
      init: GetSurgerieController(surgerieId: surgerieId),
      builder: (controller) {
        return Scaffold(
          body: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (controller.userId.isNotEmpty) {
              return Body(
                  surgerie: controller.surgerie,
                  userId: controller.userId.value,
                  provider: controller.provider.value);
            } else {
              return const Center(child: Text('No surgerie found'));
            }
          }),
        );
      },
    );
  }
}
