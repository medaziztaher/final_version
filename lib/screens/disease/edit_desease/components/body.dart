import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:medilink_app/components/custom_app_bar.dart';
import 'package:medilink_app/models/disease.dart';
import 'package:medilink_app/screens/disease/edit_desease/components/edit_desease_form.dart';
import 'package:medilink_app/utils/constants.dart';

class Body extends StatelessWidget {
  const Body({super.key, required this.disease});
  final Disease disease;
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
            CustomAppBar(
              title: "Edit Disease".tr,
            ),
            const SizedBox(
              height: 26,
            ),
            EditDiseaseForm(disease: disease),
          ],
        ),
      ),
    );
  }
}
