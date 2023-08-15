import 'package:flutter/material.dart';
import 'package:medilink_app/models/disease.dart';
import 'package:medilink_app/screens/disease/edit_desease/components/body.dart';

class EditDiseaseScreen extends StatelessWidget {
  const EditDiseaseScreen({super.key, required this.disease});
  final Disease disease;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(disease: disease),
    );
  }
}
