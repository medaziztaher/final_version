import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/models/allergy.dart';
import 'package:medilink_app/screens/allergie/get_allergie/get_allergie_screen.dart';
import 'package:medilink_app/settings/networkhandler.dart';

class EditAllergyController extends GetxController {
  Allergy allergy = Allergy(
      id: '',
      patient: '',
      severity: '',
      type: '',
      yearOfDiscovery: DateTime.now());
  GlobalKey<FormState> formKeyEditAllergy = GlobalKey<FormState>();
  NetworkHandler networkHandler = NetworkHandler();
  late RxBool isLoading = false.obs;
  late RxBool familyHistory = false.obs;
  late TextEditingController typeController;
  late TextEditingController yearOfDiscoveryController;
  late TextEditingController followupStatusController;
  late TextEditingController notesController;
  late TextEditingController severityController;
  late TextEditingController triggerController;
  late TextEditingController reactionController;
  late TextEditingController onsetController;
  List<String> severity = ['Mild', 'Moderate', 'Severe'];
  List<String> onset = ['Childhood', 'Adulthood'];
  List<String> followupStatus = ['Active', 'Resolved'];
  final List<String?> errors = [];
  EditAllergyController({required this.allergy});

  @override
  void onInit() {
    typeController = TextEditingController(text: allergy.type);
    yearOfDiscoveryController =
        TextEditingController(text: '${allergy.yearOfDiscovery}');
    followupStatusController =
        TextEditingController(text: allergy.followupStatus);
    notesController = TextEditingController(text: allergy.notes);
    severityController = TextEditingController(text: allergy.severity);
    triggerController = TextEditingController(text: allergy.trigger);
    reactionController = TextEditingController(text: allergy.reaction);
    onsetController = TextEditingController(text: allergy.onset);
    super.onInit();
  }

  @override
  void onClose() {
    typeController.dispose();
    yearOfDiscoveryController.dispose();
    followupStatusController.dispose();
    notesController.dispose();
    severityController.dispose();
    triggerController.dispose();
    reactionController.dispose();
    onsetController.dispose();
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

  String? onChangedtype(String? value) {
    if (value!.isNotEmpty) {
      removeError("type field can't be empty");
    } else if (RegExp(r'^[a-zA-Z\s.,!?]+$').hasMatch(value)) {
      removeError("only text are allowed ");
    }
    return null;
  }

  String? validatetype(String? value) {
    if (value!.isEmpty) {
      addError("type field can't be empty".tr);
      return '';
    } else if (!RegExp(r'^[a-zA-Z\s.,!?]+$').hasMatch(value)) {
      addError("only text are allowed ");
      return '';
    } else {
      removeError("type field can't be empty".tr);
      removeError("only text are allowed ");
    }
    return null;
  }

  String? validateyearOfDiscovery(String? value) {
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

  String? onChangedReaction(String? value) {
    if (value!.isNotEmpty) {
      removeError("Reaction field can't be empty");
    } else if (RegExp(r'^[a-zA-Z\s.,!?]+$').hasMatch(value)) {
      removeError("only text are allowed ");
    }
    return null;
  }

  String? validateReaction(String? value) {
    if (value!.isEmpty) {
      addError("Reaction field can't be empty".tr);
      return '';
    } else if (!RegExp(r'^[a-zA-Z\s.,!?]+$').hasMatch(value)) {
      addError("only text are allowed ");
      return '';
    } else {
      removeError("Reaction field can't be empty".tr);
      removeError("only text are allowed ");
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

  String? onChangedtrigger(String? value) {
    if (value!.isNotEmpty) {
      removeError("trigger field can't be empty");
    } else if (RegExp(r'^[a-zA-Z\s.,!?]+$').hasMatch(value)) {
      removeError("only text are allowed ");
    }
    return null;
  }

  String? validatetriggerr(String? value) {
    if (value!.isEmpty) {
      addError("trigger field can't be empty".tr);
      return '';
    } else if (!RegExp(r'^[a-zA-Z\s.,!?]+$').hasMatch(value)) {
      addError("only text are allowed ");
      return '';
    } else {
      removeError("trigger field can't be empty".tr);
      removeError("only text are allowed ");
    }
    return null;
  }

  void onChangedfamilyHistory(bool value) {
    familyHistory.value = value;
  }

  void onChangedseverity(String value) {
    severityController.text = value;
    update();
  }

  void onChangedfollowupStatus(String value) {
    followupStatusController.text = value;
    update();
  }

  void onChangedonset(String value) {
    onsetController.text = value;
    update();
  }

  Future<void> editAllergy() async {
    isLoading.value = true;
    Map<String, dynamic> data = {
      'type': typeController.text,
      'yearOfDiscovery': yearOfDiscoveryController.text,
      'followupStatus': followupStatusController.text,
      'familyHistory': familyHistory.value,
      'notes': notesController.text,
      'severity': severityController.text,
      'trigger': triggerController.text,
      'reaction': reactionController.text
    };
    try {
      final response =
          await networkHandler.put("$allergyUri/${allergy.id}", data);
      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        final message = responseData['message'];
        Get.snackbar("Allergy updated", message);
        Get.off(() => GetAllergyScreen(allergyId: allergy.id));
      } else if (response.statusCode == 500) {
        final message = responseData['error'];
        Get.snackbar('Failed', message);
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
