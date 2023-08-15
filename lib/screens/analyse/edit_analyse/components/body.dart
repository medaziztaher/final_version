import 'package:flutter/material.dart';
import 'package:medilink_app/components/custom_app_bar.dart';
import 'package:medilink_app/models/laboratory_result.dart';
import 'package:medilink_app/screens/analyse/edit_analyse/components/form.dart';
import 'package:medilink_app/utils/constants.dart';

class Body extends StatelessWidget {
  const Body({super.key, required this.analyse, required this.userId});
  final LaboratoryResult analyse;
  final String userId;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultScreenPadding,
          vertical: defaultScreenPadding,
        ),
        child: Column(
          children: [
            const CustomAppBar(
              title: "Add Analyses",
            ),
            const SizedBox(
              height: 26,
            ),
            EditAnalyseForm(analyse: analyse, userId: userId),
          ],
        ),
      ),
    );
  }
}
