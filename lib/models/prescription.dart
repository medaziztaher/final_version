import 'package:flutter/material.dart';

class Prescription {
  String id;
  String patient;
  String? provider;
  String medication;
  String dosage;
  String frequency;
  int? duration;
  DateTime startDate;
  DateTime? endDate;
  List<String>? reminder;

  Prescription({
    required this.id,
    required this.patient,
    required this.medication,
    required this.dosage,
    required this.frequency,
    this.duration,
    this.endDate,
    this.provider,
    this.reminder,
    required this.startDate,
  });

  factory Prescription.fromJson(Map<String, dynamic> json) {
    List<String>? reminder =
        json['reminder'] != null ? List<String>.from(json['reminder']) : [];
    return Prescription(
      dosage: json['dosage'],
      frequency: json['frequency'],
      id: json['_id'],
      medication: json['medication'],
      patient: json['patient'],
      provider: json['provider'] as String?,
      duration: json['duration'] as int?,
      endDate:
          json['startDate'] != null ? DateTime.parse(json['endDate']) : null,
      startDate: DateTime.parse(json['startDate']),
      reminder: reminder,
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
