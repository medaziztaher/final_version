import 'package:flutter/material.dart';

class Specialite {
  final String image;
  final String name;
  final Color theme;

  Specialite({
    required this.image,
    required this.name,
    required this.theme,
  });
}

List<Specialite> specialiste = [
  Specialite(
    image: "assets/icons/cardiogram.png",
    name: "Cardiology",
    theme: const Color.fromARGB(235, 237, 90, 92),
  ),
  Specialite(
    image: "assets/icons/brain.png",
    name: "Neurology",
    theme: const Color.fromARGB(212, 133, 147, 235),
  ),
  Specialite(
    image: "assets/icons/tooth.png",
    name: "Dental",
    theme: const Color.fromARGB(208, 86, 189, 226),
  ),
  Specialite(
    image: "assets/icons/eye.png",
    name: "Ophthalmology",
    theme: const Color.fromARGB(203, 226, 87, 161),
  ),
  Specialite(
    image: "assets/icons/lungs.png",
    name: "Pulmonology",
    theme: const Color.fromARGB(185, 0, 150, 136),
  ),
  Specialite(
    image: "assets/icons/bone.png",
    name: "Orthopedics",
    theme: const Color.fromARGB(180, 0, 170, 255),
  ),
  Specialite(
    image: "assets/icons/stethoscope.png",
    name: "General Medicine",
    theme: const Color.fromARGB(150, 0, 192, 87),
  ),
  Specialite(
    image: "assets/icons/mental-health.png",
    name: "Psychiatry",
    theme: const Color.fromARGB(180, 171, 71, 188),
  ),
];
