import 'dart:convert';

import 'package:get/get.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/models/disease.dart';
import 'package:medilink_app/settings/networkhandler.dart';

class UserDiseaseController extends GetxController {
  final RxList<Disease> diseases = <Disease>[].obs;
  String userId;
  RxBool isLoading = false.obs;
  NetworkHandler networkHandler = NetworkHandler();
  UserDiseaseController({required this.userId}) {
    _init();
  }
  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() async {
    await getUserDiseases();
  }

  Future<void> getUserDiseases() async {
    isLoading.value = true;
    try {
      final response = await networkHandler.get("$patientUri/$userId/diseases");
      if (json.decode(response.body)['status'] == true) {
        final data = json.decode(response.body)['data'] as List<dynamic>;
        final disease =
            data.map((item) => Disease.fromJson(item)).toList(growable: false);
        diseases.value = disease;
        //update();
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
