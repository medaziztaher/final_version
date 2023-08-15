import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/screens/allergie/get_allergie/get_allergie_screen.dart';
import 'package:medilink_app/settings/networkhandler.dart';

class AddAllergyController extends GetxController {
  GlobalKey<FormState> formKeyAddAllergy = GlobalKey<FormState>();
  NetworkHandler networkHandler = NetworkHandler();
  User user = User(email: '', id: '', name: '', password: '', role: '');
  AddAllergyController({required this.user});
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
  @override
  void onInit() {
    typeController = TextEditingController();
    yearOfDiscoveryController = TextEditingController();
    followupStatusController = TextEditingController();
    notesController = TextEditingController();
    severityController = TextEditingController();
    triggerController = TextEditingController();
    reactionController = TextEditingController();
    onsetController = TextEditingController();
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

  Future<void> addAllergy() async {
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
      if (formKeyAddAllergy.currentState!.validate()) {
        final response =
            await networkHandler.post("$patientUri/${user.id}/allergies", data);
        print(response.statusCode);
        if (response.statusCode == 201 || response.statusCode == 200) {
          final responseData = json.decode(response.body);
          final id = responseData['_id'];
          Get.snackbar("Allergy", "New Allergy Added");
          Get.off(() => GetAllergyScreen(
                allergyId: id,
              ));
        }
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
