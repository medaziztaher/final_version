import 'package:flutter/material.dart';

class Prescription {
  String id;
  String patient;
  String? provider;
  String medication;
  int dosage;
  String type;
  int frequency;
  int? duration;
  DateTime startDate;
  DateTime? endDate;
  String? instructions;
  List<PrescriptionReminder> reminder;

  Prescription({
    required this.id,
    required this.patient,
    required this.medication,
    required this.dosage,
    required this.type,
    required this.frequency,
    this.duration,
    this.endDate,
    this.provider,
    this.instructions,
    required this.startDate,
    required this.reminder,
  });

  factory Prescription.fromJson(Map<String, dynamic> json) {
    List<dynamic> reminderList = json['reminder'] ?? [];
    List<PrescriptionReminder> reminders = reminderList
        .map((reminderJson) => PrescriptionReminder.fromJson(reminderJson))
        .toList();

    return Prescription(
      dosage: json['dosage'],
      frequency: json['frequency'],
      id: json['_id'],
      medication: json['medication'],
      patient: json['patient'],
      provider: json['provider'] as String?,
      type: json['type'],
      duration: json['duration'] as int?,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      startDate: DateTime.parse(json['startDate']),
      instructions: json['instructions'],
      reminder: reminders,
    );
  }
}

class PrescriptionReminder {
  String uuid;
  int hour;
  int minute;
  bool done;

  PrescriptionReminder({
    required this.uuid,
    required this.hour,
    required this.minute,
    required this.done,
  });

  factory PrescriptionReminder.fromJson(Map<String, dynamic> json) {
    return PrescriptionReminder(
      uuid: json['uuid'],
      hour: json['hour'],
      minute: json['minute'],
      done: json['done'],
    );
  }
}

List<Map<String, dynamic>> upcomingPills = [
  {
    "pillName": "Solutab",
    "instruction": "Take on an empty stomach",
    "date": "7h00",
    "theme": const Color.fromARGB(91, 133, 147, 235),
    "dosage": "2 cups",
  },
  {
    "pillName": "Vitamins",
    "instruction": "Take 30 mins before a meal",
    "date": "15h00",
    "theme": const Color.fromARGB(91, 229, 145, 220),
    "dosage": "1 Pills",
  }
];
