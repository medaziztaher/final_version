import 'package:flutter/material.dart';
import 'package:medilink_app/api/paths.dart';

class HealthMetric {
  String id;
  String patient;
  String metricName;
  String metricIcon;
  String metricUnit;
  int value;
  DateTime date;
  Color? color;

  HealthMetric(
      {required this.id,
      required this.patient,
      required this.metricName,
      required this.value,
      required this.date,
      required this.metricIcon,
      required this.metricUnit});

  factory HealthMetric.fromJson(Map<String, dynamic> json) {
    String? icon = json['metricIcon'];
    icon = icon != null ? "$iconPath/$icon" : "";
    return HealthMetric(
        id: json['_id'],
        patient: json['patient'],
        metricName: json['metricName'],
        value: json['value'],
        metricIcon: icon,
        metricUnit: json['metricUnit'],
        date: DateTime.parse(json['date']));
  }
}

class Metric {
  String healthMetric;
  String unit;
  String icon;
  Color theme;

  Metric({
    required this.healthMetric,
    required this.unit,
    required this.icon,
    required this.theme,
  });
}

List<Metric> health = [
  Metric(
    healthMetric: "Blood Pressure",
    unit: "mmHg",
    icon: "assets/icons/blood.png",
    theme: const Color.fromARGB(214, 237, 90, 93),
  ),
  Metric(
    healthMetric: "Heart Rate",
    unit: "bpm",
    icon: "assets/icons/heart-rate.png",
    theme: const Color.fromARGB(139, 226, 87, 161),
  ),
  Metric(
    healthMetric: "Calories",
    unit: "Calories",
    icon: "assets/icons/calories.png",
    theme: const Color.fromARGB(138, 180, 87, 226),
  ),
  Metric(
    healthMetric: "Sleep Hours",
    unit: "Hours",
    icon: "assets/icons/sleep.png",
    theme: const Color.fromARGB(120, 48, 63, 202),
  ),
  Metric(
    healthMetric: "Body Mass Index (BMI)",
    unit: "BMI",
    icon: "assets/icons/bmi.png",
    theme: const Color.fromARGB(180, 255, 135, 0),
  ),
  Metric(
    healthMetric: "Glucose Levels",
    unit: "Glucose",
    icon: "assets/icons/blood-glucose.png",
    theme: const Color.fromARGB(210, 255, 0, 0),
  ),
  Metric(
    healthMetric: "Cholesterol Levels",
    unit: "Cholesterol",
    icon: "assets/icons/cholesterol.png",
    theme: const Color.fromARGB(180, 0, 170, 255),
  ),
  Metric(
    healthMetric: "Physical Activity",
    unit: "Activity",
    icon: "assets/icons/physical-activity.png",
    theme: const Color.fromARGB(150, 0, 192, 87),
  ),
  Metric(
    healthMetric: "Hydration Levels",
    unit: "Hydration",
    icon: "assets/icons/hydration.png",
    theme: const Color.fromARGB(180, 0, 150, 136),
  ),
];
