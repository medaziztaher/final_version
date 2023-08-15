import 'dart:convert';

import 'package:get/get.dart';
import 'package:medilink_app/api/global.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/models/prescription.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/settings/networkhandler.dart';

class GetPrescController extends GetxController {
  String prescId;
  RxString userId = "".obs;
  Prescription prescription = Prescription(
      dosage: '',
      frequency: '',
      id: '',
      medication: '',
      patient: '',
      startDate: DateTime.now());

  RxBool isLoading = false.obs;
  NetworkHandler networkHandler = NetworkHandler();
  RxString provider = "".obs;

  GetPrescController({required this.prescId}) {
    _init();
  }
  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() async {
    String? userId = await getUserId();
    this.userId.value = userId!;
    await getPrescription();
    await getProvider();
  }

  Future<void> getProvider() async {
    try {
      final response =
          await networkHandler.get("$userUri/${prescription.provider}");
      if (json.decode(response.body)['status'] == true) {
        User user = User.fromJson(json.decode(response.body)['data']);
        provider.value = user.name;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getPrescription() async {
    try {
      final response = await networkHandler.get("$prescriptionUri/$prescId");
      print(json.decode(response.body)['status']);
      if (json.decode(response.body)['status'] == true) {
        prescription =
            Prescription.fromJson(json.decode(response.body)['data']);
        update();
      }
    } catch (e) {
      print(e);
    }
  }
}
