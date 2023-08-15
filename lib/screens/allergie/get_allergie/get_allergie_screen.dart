import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink_app/models/allergy.dart';
import 'package:medilink_app/screens/allergie/get_allergie/components/body.dart';
import 'package:medilink_app/screens/allergie/get_allergie/get_allergie_controller.dart';

class GetAllergyScreen extends StatelessWidget {
  const GetAllergyScreen({super.key, required this.allergyId});
  final String allergyId;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetAllergyController>(
      init: GetAllergyController(allergyId: allergyId),
      builder: (controller) {
        return Scaffold(
          body: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (controller.allergy !=
                Allergy(
                    id: '',
                    patient: '',
                    severity: '',
                    type: '',
                    yearOfDiscovery: DateTime.now())) {
              return Body(allergy: controller.allergy);
            } else {
              return const Center(child: Text('No allergie found'));
            }
          }),
        );
      },
    );
  }
}
