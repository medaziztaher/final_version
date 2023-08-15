import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/models/prescription.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/settings/local_notifications.dart';
import 'package:medilink_app/settings/networkhandler.dart';
import 'package:medilink_app/settings/shared_prefs.dart';
import 'package:medilink_app/utils/constants.dart';
import 'dart:math';

class AddPrescriptionController extends GetxController {
  GlobalKey<FormState> formKeyPrescription = GlobalKey<FormState>();
  late TextEditingController medicamentController;
  late TextEditingController dateDebutController;
  late TextEditingController dateFinController;
  Prescription prescription = Prescription(
      dosage: 0,
      frequency: 0,
      id: '',
      medication: '',
      patient: '',
      startDate: DateTime.now(),
      reminder: [],
      type: '');
  int? dosageController;
  int? frequencyController = 1;
  late TextEditingController typeController;
  late RxBool isLoading = false.obs;
  NetworkHandler networkHandler = NetworkHandler();
  User user = User(email: '', id: '', name: '', password: '', role: '');
  AddPrescriptionController({required this.user});
  final List<String?> errors = [];
  List<TimeOfDay> reminders = [TimeOfDay(hour: 8, minute: 5)];

  @override
  void onInit() {
    medicamentController = TextEditingController();
    dateDebutController = TextEditingController();
    dateFinController = TextEditingController();
    typeController = TextEditingController(text: 'Pills');
    NotificationService().initNotification();
    super.onInit();
  }

  @override
  void onClose() {
    medicamentController.dispose();
    dateDebutController.dispose();
    dateFinController.dispose();
    typeController.dispose();
    super.onClose();
  }

  void addReminder(TimeOfDay newReminder) {
    reminders.add(newReminder);
    update(); // This triggers the UI to update when a reminder is added.
  }

  void onChangedfrequency(String value) {
    int newFrequency = int.parse(value);

    if (newFrequency >= 1) {
      // Add or remove reminders based on the new frequency
      while (reminders.length < newFrequency) {
        addReminder(TimeOfDay.now()); // Initialize with current time
      }
      while (reminders.length > newFrequency) {
        reminders.removeLast();
      }
    } else {
      reminders.clear();
    }

    frequencyController = newFrequency;
    update();
  }

  void removeReminder(int index) {
    reminders.removeAt(index);
    update(); // This triggers the UI to update when a reminder is removed.
  }

  void onChangeddatedebut(String? value) {
    if (value!.isNotEmpty) {
      dateDebutController.text = value;
    }
    update();
  }

  void onChangeddatefin(String? value) {
    if (value!.isNotEmpty) {
      dateFinController.text = value;
    }
    update();
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
          prescription = Prescription.fromJson(responseData['data']);
          update();
          if (reminders.isNotEmpty &&
              prescription.endDate != null &&
              prescription.endDate!.isAfter(DateTime.now())) {
            for (int i = 0; i < reminders.length; i++) {
              int randomInt = Random().nextInt(100);
              Map<String, dynamic> datareminder = {
                'uuid': Pref().prefs!.getString(kuuid),
                'hour': reminders[i].hour,
                'minute': reminders[i].minute,
                'prescriptionuuid': randomInt
              };
              try {
                final reminderResponse = await networkHandler.put(
                    "$prescriptionUri/${prescription.id}/set-reminder",
                    datareminder);
                if (reminderResponse.statusCode == 200) {
                  NotificationService().scheduleDailyNotifications(
                      title: "Rappel de médication",
                      body: "Reminder Set",
                      notificationTime: reminders[i],
                      numberOfDays: prescription.duration!);

                  // Get.snackbar("Reminder", "Noti set");
                } else {
                  print(
                      "${reminderResponse.statusCode} : ${reminderResponse.body}");
                  print("Error");
                }
              } catch (e) {
                print(e);
              }
            }
          }
          //  Get.snackbar("Prescription", "Prescription added sucessfuly");
          // Get.off(() => GetPrescScreen(prescId: id));
        }
      } else {
        //Get.snackbar("Prescription", "Prescription failed");
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
