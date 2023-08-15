import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink_app/screens/radiographie/get_radiographie/components/body.dart';
import 'package:medilink_app/screens/radiographie/get_radiographie/get_radiographie_controller.dart';



class GetRadioScreen extends StatelessWidget {
  const GetRadioScreen({super.key, required this.radioId});
  final String radioId;

  @override
  Widget build(BuildContext context) {
    print(radioId);
    return GetBuilder<GetRadioController>(
      init: GetRadioController(radioId: radioId),
      builder: (controller) {
        return Scaffold(
          body: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (controller.userId.isNotEmpty) {
              return Body(
                  radiographie: controller.radiographie,
                  userId: controller.userId.value,
                  provider: controller.provider.value);
            } else {
              return const Center(child: Text('No Radiographie found'));
            }
          }),
        );
      },
    );
  }
}
