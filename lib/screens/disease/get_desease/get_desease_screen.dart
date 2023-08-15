import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink_app/models/disease.dart';
import 'package:medilink_app/screens/disease/get_desease/components/body.dart';
import 'package:medilink_app/screens/disease/get_desease/get_desease_controller.dart';

class GetDiseaseScreen extends StatelessWidget {
  const GetDiseaseScreen({super.key, required this.diseaseId});
  final String diseaseId;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetDiseaseController>(
      init: GetDiseaseController(diseaseId: diseaseId),
      builder: (controller) {
        return Scaffold(
          body: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (controller.disease !=
                Disease(
                    chronicDisease: false,
                    detectedIn: DateTime.now(),
                    diseaseName: '',
                    familyHistory: false,
                    genetic: false,
                    id: '',
                    patient: '',
                    recurrence: false,
                    severity: '')) {
              return Body(disease: controller.disease);
            } else {
              return const Center(child: Text('no disease found'));
            }
          }),
        );
      },
    );
  }
}
