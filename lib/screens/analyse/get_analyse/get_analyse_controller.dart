import 'dart:convert';

import 'package:get/get.dart';
import 'package:medilink_app/api/global.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/models/laboratory_result.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/settings/networkhandler.dart';

class GetAnalyseController extends GetxController {
  String analyseId;
  RxString userId = "".obs;
  late Rx<LaboratoryResult> analyse = LaboratoryResult(
          abnormalFlag: false,
          date: DateTime.now(),
          id: '',
          patient: '',
          reason: '',
          result: '',
          testName: '')
      .obs;
  RxBool isLoading = false.obs;
  NetworkHandler networkHandler = NetworkHandler();
  RxString provider = "".obs;

  GetAnalyseController({required this.analyseId}) {
    _init();
  }
  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() async {
    userId.value = (await getUserId())!;
    await getAnalyse();
    await getProvider();
  }

  Future<void> getProvider() async {
    try {
      final response =
          await networkHandler.get("$userUri/${analyse.value.provider}");
      if (json.decode(response.body)['status'] == true) {
        User user = User.fromJson(json.decode(response.body)['data']);
        provider.value = user.name;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getAnalyse() async {
    try {
      final response =
          await networkHandler.get("$laboratoryResultUri/$analyseId");

      print(json.decode(response.body)['data']);
      if (json.decode(response.body)['status'] == true) {
        analyse.value =
            LaboratoryResult.fromJson(json.decode(response.body)['data']);
      }
    } catch (e) {
      print(e);
    }
  }
}
