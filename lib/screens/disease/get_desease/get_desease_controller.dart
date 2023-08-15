import 'dart:convert';

import 'package:get/get.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/models/disease.dart';
import 'package:medilink_app/settings/networkhandler.dart';

class GetDiseaseController extends GetxController {
  String diseaseId;
  Disease disease = Disease(
      chronicDisease: false,
      detectedIn: DateTime.now(),
      diseaseName: '',
      familyHistory: false,
      genetic: false,
      id: '',
      patient: '',
      recurrence: false,
      severity: '');
  RxBool isLoading = false.obs;
  NetworkHandler networkHandler = NetworkHandler();

  GetDiseaseController({required this.diseaseId}) {
    _init();
  }
  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() async {
    await getDisease();
  }

  Future<void> getDisease() async {
    try {
      final response = await networkHandler.get("$diseaseUri/$diseaseId");
      if (json.decode(response.body)['status'] == true) {
        disease = Disease.fromJson(json.decode(response.body)['data']);
        update();
      }
    } catch (e) {
      print(e);
    }
  }
}
