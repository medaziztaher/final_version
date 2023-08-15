import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink_app/screens/analyse/get_analyse/components/body.dart';
import 'package:medilink_app/screens/analyse/get_analyse/get_analyse_controller.dart';

class GetAnalyseScreen extends StatelessWidget {
  const GetAnalyseScreen({super.key, required this.analyseId});
  final String analyseId;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetAnalyseController>(
      init: GetAnalyseController(analyseId: analyseId),
      builder: (controller) {
        return Scaffold(
          body: Obx(
            () {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.userId.isNotEmpty) {
                return Body(
                    analyse: controller.analyse.value,
                    userId: controller.userId.value,
                    provider: controller.provider.value);
              } else {
                return const Center(child: Text('No Analyse found'));
              }
            },
          ),
        );
      },
    );
  }
}
