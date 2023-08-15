import 'dart:convert';

import 'package:get/get.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/models/allergy.dart';
import 'package:medilink_app/settings/networkhandler.dart';

class GetAllergyController extends GetxController {
  String allergyId;
  Allergy allergy = Allergy(
      id: '',
      patient: '',
      severity: '',
      type: '',
      yearOfDiscovery: DateTime.now());
  RxBool isLoading = false.obs;
  NetworkHandler networkHandler = NetworkHandler();

  GetAllergyController({required this.allergyId}) {
    _init();
  }
  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() async {
    await getAllergy();
  }

  Future<void> getAllergy() async {
    isLoading.value = true;
    try {
      final response = await networkHandler.get("$allergyUri/$allergyId");
      if (response.statusCode == 200) {
        allergy = Allergy.fromJson(json.decode(response.body)['data']);
        update();
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
