import 'dart:convert';

import 'package:get/get.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/models/prescription.dart';
import 'package:medilink_app/settings/networkhandler.dart';


class UserPrescController extends GetxController {
  final RxList<Prescription> prescriptions = <Prescription>[].obs;
  String userId;
  RxBool isLoading = false.obs;
  NetworkHandler networkHandler = NetworkHandler();
  UserPrescController({required this.userId}) {
    _init();
  }
  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() async {
    await getUserPrescriptions();
  }

  Future<void> getUserPrescriptions() async {
    isLoading.value = true;
    try {
      final response =
          await networkHandler.get("$patientUri/$userId/prescriptions");
      if (json.decode(response.body)['status'] == true) {
        final data = json.decode(response.body)['data'] as List<dynamic>;
        final prescription = data
            .map((item) => Prescription.fromJson(item))
            .toList(growable: false);
        prescriptions.value = prescription;
        //update();
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
