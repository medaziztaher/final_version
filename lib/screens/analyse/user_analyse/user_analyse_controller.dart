import 'dart:convert';

import 'package:get/get.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/models/laboratory_result.dart';
import 'package:medilink_app/settings/networkhandler.dart';

class UserAnalysesController extends GetxController {
  final RxList<LaboratoryResult> analyses = <LaboratoryResult>[].obs;
  String userId;
  RxBool isLoading = false.obs;
  NetworkHandler networkHandler = NetworkHandler();
  UserAnalysesController({required this.userId}) {
    _init();
  }
  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() async {
    await getUserAnalyse();
  }

  Future<void> getUserAnalyse() async {
    isLoading.value = true;
    try {
      final response =
          await networkHandler.get("$patientUri/$userId/labresult");
      if (json.decode(response.body)['status'] == true) {
        final data = json.decode(response.body)['data'] as List<dynamic>;
        final analyse = data
            .map((item) => LaboratoryResult.fromJson(item))
            .toList(growable: false);
        analyses.value = analyse;
        //update();
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
