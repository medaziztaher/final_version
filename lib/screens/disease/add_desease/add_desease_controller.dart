import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/screens/disease/get_desease/get_desease_screen.dart';
import 'package:medilink_app/settings/networkhandler.dart';

class AddDiseaseController extends GetxController {
  GlobalKey<FormState> formKeyAddDisease = GlobalKey<FormState>();
  NetworkHandler networkHandler = NetworkHandler();
  User user = User(email: '', id: '', name: '', password: '', role: '');
  AddDiseaseController({required this.user});
  late RxBool isLoading = false.obs;
  late RxBool genetic = false.obs;
  late RxBool chronicDisease = false.obs;
  late RxBool familyHistory = false.obs;
  late RxBool recurrence = false.obs;
  late TextEditingController diseaseNameController;
  late TextEditingController specialityController;
  late TextEditingController severityController;
  late TextEditingController notesController;
  late TextEditingController detectedInController;
  late TextEditingController curedInController;
  late TextEditingController symptomsController;
  late TextEditingController medicationsController;
  List<String> severity = ['Mild', 'Moderate', 'Severe'];

  final List<String?> errors = [];
  @override
  void onInit() {
    super.onInit();
    diseaseNameController = TextEditingController();
    curedInController = TextEditingController();
    detectedInController = TextEditingController();
    notesController = TextEditingController();
    severityController = TextEditingController();
    specialityController = TextEditingController();
    symptomsController = TextEditingController();
    medicationsController = TextEditingController();
  }

  @override
  void onClose() {
    diseaseNameController.dispose();
    curedInController.dispose();
    detectedInController.dispose();
    notesController.dispose();
    severityController.dispose();
    specialityController.dispose();
    symptomsController.dispose();
    medicationsController.dispose();
    super.onClose();
  }

  void addError(String? error) {
    if (error != null && !errors.contains(error)) {
      errors.add(error);
      update();
    }
  }

  void removeError(String? error) {
    if (error != null && errors.contains(error)) {
      errors.remove(error);
      update();
    }
  }

  String? onChangedspeciality(String? value) {
    if (value!.isNotEmpty) {
      removeError("speciality field can't be empty");
    } else if (RegExp(r'^[a-zA-Z\s.,!?]+$').hasMatch(value)) {
      removeError("only text are allowed ");
    }
    return null;
  }

  String? validatespeciality(String? value) {
    if (value!.isEmpty) {
      addError("speciality field can't be empty".tr);
      return '';
    } else if (!RegExp(r'^[a-zA-Z\s.,!?]+$').hasMatch(value)) {
      addError("only text are allowed ");
      return '';
    } else {
      removeError("speciality field can't be empty".tr);
      removeError("only text are allowed ");
    }
    return null;
  }

  String? onChangeddiseaseName(String? value) {
    if (value!.isNotEmpty) {
      removeError("diseaseName field can't be empty");
    } else if (RegExp(r'^[a-zA-Z\s.,!?]+$').hasMatch(value)) {
      removeError("only text are allowed ");
    }
    return null;
  }

  String? validatediseaseName(String? value) {
    if (value!.isEmpty) {
      addError("diseaseName field can't be empty".tr);
      return '';
    } else if (!RegExp(r'^[a-zA-Z\s.,!?]+$').hasMatch(value)) {
      addError("only text are allowed ");
      return '';
    } else {
      removeError("diseaseName field can't be empty".tr);
      removeError("only text are allowed ");
    }
    return null;
  }

  String? validatecuredIn(String? value) {
    DateTime? curedInDate = DateTime.tryParse(value!);
    DateTime? detectedInDate = DateTime.tryParse(detectedInController.text);
    if (curedInDate == null) {
      addError("Please enter a valid date");
      return '';
    } else if (curedInDate.isBefore(detectedInDate!)) {
      addError("Cured in date must be after detected in date");
      return '';
    } else {
      removeError("Please enter the date");
      removeError("Please enter a valid date");
      removeError("Cured in date must be after detected in date");
    }

    return null;
  }

  String? validatedetectedIn(String? value) {
    if (value!.isEmpty) {
      addError("Please enter the date");
      return '';
    } else {
      DateTime? date = DateTime.tryParse(value);
      if (date == null) {
        addError("Please enter a valid date");
        return '';
      } else if (date.isAfter(DateTime.now())) {
        addError("Date must be before today's date");
        return '';
      } else {
        removeError("Please enter the date");
      }
    }
    return null;
  }

  String? onChangednotes(String? value) {
    if (value!.isNotEmpty) {
      removeError("notes field can't be empty");
    } else if (RegExp(r'^[a-zA-Z\s.,!?]+$').hasMatch(value)) {
      removeError("only text are allowed ");
    }
    return null;
  }

  String? validatenotes(String? value) {
    if (value!.isEmpty) {
      addError("notes field can't be empty".tr);
      return '';
    } else if (!RegExp(r'^[a-zA-Z\s.,!?]+$').hasMatch(value)) {
      addError("only text are allowed ");
      return '';
    } else {
      removeError("notes field can't be empty".tr);
      removeError("only text are allowed ");
    }
    return null;
  }

  void onChangedgenetic(bool value) {
    genetic.value = value;
  }

  void onChangedchronicDisease(bool value) {
    chronicDisease.value = value;
  }

  void onChangedfamilyHistory(bool value) {
    familyHistory.value = value;
  }

  void onChangedrecurrence(bool value) {
    recurrence.value = value;
  }

  void onChangedseverity(String value) {
    severityController.text = value;
    update();
  }

  Future<void> addDisease() async {
    isLoading.value = true;
    Map<String, dynamic> data = {
      'diseaseName': specialityController.text,
      'speciality': genetic.value,
      'severity': chronicDisease.value,
      'genetic': detectedInController.text,
      'chronicDisease': notesController.text,
      'detectedIn': curedInController.text,
      'curedIn': curedInController.text,
      'symptoms': curedInController.text,
      'medications': curedInController.text,
      'familyHistory': curedInController.text,
      'recurrence': curedInController.text,
      'notes': curedInController.text,
    };
    try {
      if (formKeyAddDisease.currentState!.validate()) {
        final response =
            await networkHandler.post("$patientUri/${user.id}/diseases", data);
        if (response.statusCode == 201 || response.statusCode == 200) {
          final responseData = json.decode(response.body);
          final id = responseData['_id'];
          Get.snackbar("Disease", "New Disease Added");
          Get.off(() => GetDiseaseScreen(
                diseaseId: id,
              ));
          print(responseData);
          specialityController.clear();
          detectedInController.clear();
          curedInController.clear();
        }
        notesController.clear();
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
