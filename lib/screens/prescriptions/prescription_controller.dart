import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/models/reminder.dart';
import 'package:medilink_app/settings/networkhandler.dart';
import 'package:medilink_app/settings/shared_prefs.dart';
import 'package:medilink_app/utils/constants.dart';

class PrescriptionController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<Reminder> prescriptionsReminders = <Reminder>[].obs;
  NetworkHandler networkHandler = NetworkHandler();
  DateTime selectedDate = DateTime.now();
  @override
  void onInit() {
    getPrescriptions(selectedDate);
    super.onInit();
  }

  void getPrescriptions(selectedDate) async {
    isLoading.value = true;
    print(
        "$prescriptionUri/${Pref().prefs!.getString(kuuid)}/${DateFormat("yyyy-MM-dd").format(selectedDate)}");
    try {
      final response = await networkHandler.get(
        "$prescriptionUri/reminders/${Pref().prefs!.getString(kuuid)}/${DateFormat("yyyy-MM-dd").format(selectedDate)}",
      );
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        final List<Reminder> reminders =
            data.map((item) => Reminder.fromJson(item)).toList();
        prescriptionsReminders.assignAll(reminders);
      } else {
        print(
            'API returned an error: ${json.decode(response.body)['message']}');
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void updateSelectedDate(DateTime newDate) {
    selectedDate = newDate;
    update();
    getPrescriptions(
        selectedDate); // Automatically fetch prescriptions for the new date
  }
}
