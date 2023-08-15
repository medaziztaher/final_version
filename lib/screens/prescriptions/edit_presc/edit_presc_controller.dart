import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/models/prescription.dart';
import 'package:medilink_app/screens/prescriptions/get_presc/get_presc_screen.dart';
import 'package:medilink_app/settings/networkhandler.dart';

class EditPrescriptionController extends GetxController {
  GlobalKey<FormState> formKeyPrescription = GlobalKey<FormState>();
  late TextEditingController _medicamentController = TextEditingController();
  late TextEditingController _instructionsController = TextEditingController();
  late TextEditingController _dateDebutController = TextEditingController();
  late TextEditingController _dateFinController = TextEditingController();

  late int _dosageQuantity = 1;
  late String _dosage = '1 Pills';
  late int _frequency = 1;

  late RxBool _isLoading = false.obs;
  final NetworkHandler _networkHandler = NetworkHandler();

  final List<String?> errors = [];

  List<Map<String, dynamic>> reminder = [
    {
      'notification': '08 : 00 AM',
      'done': false,
    }
  ];
  EditPrescriptionController({required this.prescription});
  Prescription prescription = Prescription(
      dosage: '',
      frequency: '',
      id: '',
      medication: '',
      patient: '',
      startDate: DateTime.now());

  // Getters

  int get frequency => _frequency;

  set frequency(int value) {
    _frequency = value;
    _addNotifications(value);
  }

  void _addNotifications(int value) {
    final currentLength = reminder.length;
    final diff = value - currentLength;

    if (diff > 0) {
      // Add new items
      for (int i = 0; i < diff; i++) {
        reminder.add({
          'notification': '08 : 00 AM',
          'done': false,
        });
      }
    } else if (diff < 0) {
      for (int i = 0; i < -diff; i++) {
        reminder.removeLast();
      }
    }

    print(reminder);
  }

  String get dosage => _dosage;
  set dosage(String value) {
    _dosage = value;
  }

  RxBool get isLoading => _isLoading;

  set isLoading(RxBool value) {
    _isLoading = value;
  }

  NetworkHandler get networkHandler => _networkHandler;

  String get medicament => _medicamentController.text;

  set medicament(String value) {
    _medicamentController.text = value;
  }

  String get instructions => _instructionsController.text;
  set instructions(String value) {
    _instructionsController.text = value;
  }

  String get dateDebut => _dateDebutController.text;
  set dateDebut(String value) {
    _dateDebutController.text = value;
  }

  String get dateFin => _dateFinController.text;

  set dateFin(String value) {
    _dateFinController.text = value;
  }

  // Controller
  TextEditingController get medicamentController => _medicamentController;

  @override
  void onInit() {
    _medicamentController = TextEditingController();
    _dateDebutController = TextEditingController();
    _instructionsController = TextEditingController();
    _dateFinController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    _medicamentController.dispose();
    _dateDebutController.dispose();
    _dateFinController.dispose();
    _instructionsController.dispose();
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

  String? onChangedMedicament(String? value) {
    if (value!.isNotEmpty) {
      removeError("Medicament field can't be empty");
    } else if (RegExp(r'^[a-zA-Z\s.,!?]+$').hasMatch(value)) {
      removeError("only text are allowed ");
    }
    return null;
  }

  String? validateMedicament(String? value) {
    if (value!.isEmpty) {
      addError("Medicament field can't be empty".tr);
      return '';
    } else if (!RegExp(r'^[a-zA-Z\s.,!?]+$').hasMatch(value)) {
      addError("only text are allowed ");
      return '';
    } else {
      removeError("Medicament field can't be empty".tr);
      removeError("Only text are allowed ");
    }
    return null;
  }

  String? validateInstructions(String? value) {
    if (value!.isEmpty) {
      addError("Instructions field can't be empty".tr);
      return '';
    } else if (!RegExp(r'^[a-zA-Z\s.,!?]+$').hasMatch(value)) {
      addError("only text are allowed ");
      return '';
    } else {
      removeError("Instructions field can't be empty".tr);
      removeError("Only text are allowed ");
    }
    return null;
  }

  String? validateDateDebut(String? value) {
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

  String? validateDateFin(String? value) {
    DateTime? curedInDate = DateTime.tryParse(value!);
    DateTime? detectedInDate = DateTime.tryParse(_dateDebutController.text);
    if (curedInDate == null) {
      addError("Please enter a valid date");
      return '';
    } else if (curedInDate.isBefore(detectedInDate!)) {
      addError("Last date must be after start date");
      return '';
    } else {
      removeError("Please enter the date");
      removeError("Please enter a valid date");
      removeError("Last date  must be after start date");
    }

    return null;
  }

  String? validateDosage(String? value) {
    if (value!.isEmpty) {
      addError("Dosage field can't be empty".tr);
      return '';
    } else {
      removeError("Dosage field can't be empty".tr);
    }
    return null;
  }

  String? validateFrequence(String? value) {
    if (value!.isEmpty) {
      addError("Frequence field can't be empty".tr);
      return '';
    } else {
      removeError("Frequence field can't be empty".tr);
    }
    return null;
  }

  void onChangedDosageQuantity(String? value) {
    if (value!.isNotEmpty) {
      _dosageQuantity = int.parse(value);
    }
  }

  void onChangedDosage(String? value) {
    if (value!.isNotEmpty) {}
    _dosage = "$_dosageQuantity $value";
    update();
  }

  void onChangedFrequence(int value) {
    _frequency = value;
    update();
  }

  Future<void> updatePrescription() async {
    isLoading.value = true;
    Map<String, dynamic> data = {
      'medication': medicament,
      'dosage': dosage,
      'frequency': frequency,
      'startDate': dateDebut,
      'endDate': dateFin,
      'reminder': reminder,
    };
    try {
      if (formKeyPrescription.currentState!.validate()) {
        var response = await networkHandler.put(
            "$prescriptionUri/${prescription.id}", data);
        print(response.statusCode);
        final responseData = json.decode(response.body);
        if (response.statusCode == 200) {
          final id = responseData['_id'];
          final message = responseData['message'];
          Get.snackbar("Prescription updated", message);
          Get.off(() => GetPrescScreen(prescId: id));
        } else if (response.statusCode == 500) {
          final message = responseData['error'];
          Get.snackbar('Failed', message);
        }
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
