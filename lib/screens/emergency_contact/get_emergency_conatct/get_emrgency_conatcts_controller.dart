import 'dart:convert';

import 'package:get/get.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/models/emergency_contact.dart';
import 'package:medilink_app/settings/networkhandler.dart';

class UserEmergencyContactController extends GetxController {
  final RxList<EmergencyContact> emergencyContacts = <EmergencyContact>[].obs;
  String userId;
  RxBool isLoading = false.obs;
  NetworkHandler networkHandler = NetworkHandler();
  UserEmergencyContactController({required this.userId}) {
    _init();
  }
  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() async {
    await getUserEmergencyContacts();
  }

  Future<void> getUserEmergencyContacts() async {
    isLoading.value = true;
    try {
      final response =
          await networkHandler.get("$patientUri/$userId/emergency-contacts");
      if (json.decode(response.body)['status'] == true) {
        final data = json.decode(response.body)['data'] as List<dynamic>;
        final emergencyContact = data
            .map((item) => EmergencyContact.fromJson(item))
            .toList(growable: false);
        emergencyContacts.value = emergencyContact;
        //update();
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
