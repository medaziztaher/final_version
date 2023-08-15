import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/settings/networkhandler.dart';

class AddPrescriptionController extends GetxController {
  GlobalKey<FormState> formKeyPrescription = GlobalKey<FormState>();
  late TextEditingController medicamentController;
  late TextEditingController dateDebutController;
  late TextEditingController dateFinController;
  int? dosageController;
  int? frequencyController;
  late TextEditingController typeController;
  late RxBool isLoading = false.obs;
  NetworkHandler networkHandler = NetworkHandler();
  User user = User(email: '', id: '', name: '', password: '', role: '');
  AddPrescriptionController({required this.user});
  final List<String?> errors = [];


  List<TimeOfDay> reminders = [];
  void addReminder(TimeOfDay newReminder) {
    reminders.add(newReminder);
    update(); // This triggers the UI to update when a reminder is added.
  }

  void removeReminder(int index) {
    reminders.removeAt(index);
    update(); // This triggers the UI to update when a reminder is removed.
  }

  Future<void> addPrescription() async {
    isLoading.value = true;
    print(reminders);

    Map<String, dynamic> data = {
      'medication': medicamentController.text,
      'type': typeController.text,
      'dosage': dosageController,
      'frequency': frequencyController,
      'startDate': dateDebutController.text,
      'endDate': dateFinController.text,
    };

    print(data);

    try {
      if (formKeyPrescription.currentState!.validate()) {
        final response = await networkHandler.post(
            "$patientUri/${user.id}/prescriptions", data);
        final responseData = json.decode(response.body);

        print(response.statusCode);
        print(responseData);
        if (response.statusCode == 200 || response.statusCode == 201) {
          final id = responseData['_id'];
          print(id);
          Get.snackbar("Prescription", "Prescription added sucessfuly");
          // Get.off(() => GetPrescScreen(prescId: id));
        }
      } else {
        Get.snackbar("Prescription", "Prescription failed");
      }
    } finally {
      isLoading.value = false;
    }
  }
}
