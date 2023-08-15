import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink_app/screens/prescriptions/add_presc/add_presc_screen.dart';
import 'package:medilink_app/screens/prescriptions/get_presc/components/old_body.dart';
import 'package:medilink_app/screens/prescriptions/get_presc/get_presc_controller.dart';
import 'package:medilink_app/utils/constants.dart';

class GetPrescScreen extends StatelessWidget {
  const GetPrescScreen({super.key, required this.prescId});
  final String prescId;

  @override
  Widget build(BuildContext context) {
    print(prescId);
    return GetBuilder<GetPrescController>(
      init: GetPrescController(prescId: prescId),
      builder: (controller) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: primaryColor,
            child: const ImageIcon(
              AssetImage("assets/icons/add.png"),
              size: 36,
              color: Colors.white,
            ),
            onPressed: () {
              Get.to(const AddPrescrptionScreen());
            },
          ),
          body: Obx(() {
            if (controller.isLoading.value) {
              return const Center(
                  child: CircularProgressIndicator(
                color: primaryColor,
              ));
            }
            if (controller.userId.isNotEmpty) {
              return Body(
                  prescription: controller.prescription,
                  userId: controller.userId.value,
                  provider: controller.provider.value);
            } else {
              return const Center(child: Text('No Prescriptions found'));
            }
          }),
        );
      },
    );
  }
}
