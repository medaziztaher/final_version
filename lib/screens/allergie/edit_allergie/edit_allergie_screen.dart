import 'package:flutter/material.dart';
import 'package:medilink_app/models/allergy.dart';
import 'package:medilink_app/screens/allergie/edit_allergie/components/body.dart';

class EditAllergyScreen extends StatelessWidget {
  const EditAllergyScreen({super.key, required this.allergie});
  final Allergy allergie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(allergie: allergie),
    );
  }
}
