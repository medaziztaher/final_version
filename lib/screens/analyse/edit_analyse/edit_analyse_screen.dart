import 'package:flutter/material.dart';
import 'package:medilink_app/models/laboratory_result.dart';
import 'package:medilink_app/screens/analyse/edit_analyse/components/body.dart';


class EditAnalyseScreen extends StatelessWidget {
  const EditAnalyseScreen(
      {super.key, required this.analyse, required this.userId});
  final LaboratoryResult analyse;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(analyse.testName),
      ),
      body: Body(analyse: analyse, userId: userId),
    );
  }
}
