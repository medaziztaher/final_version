import 'package:flutter/material.dart';

class Reminder {
  String id;
  String name;
  String? instructions;
  String dosage;
  String type;
  bool done;
  TimeOfDay notificationTime;

  Reminder(
      {required this.id,
      required this.name,
      this.instructions,
      required this.done,
      required this.dosage,
      required this.type,
      required this.notificationTime});

  factory Reminder.fromJson(Map<String, dynamic> json) {
    int hour = json['firstReminderTime']['hour'];
    int minute = json['firstReminderTime']['minute'];
    return Reminder(
      done: json['done'],
      dosage: json['dosage'],
      id: json['_id'],
      name: json['name'],
      notificationTime: TimeOfDay(hour: hour, minute: minute),
      type: json['type'],
    );
  }
}
