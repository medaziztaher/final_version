import 'package:flutter/material.dart';
import 'package:medilink_app/components/custom_app_bar.dart';
import 'package:medilink_app/models/radiographie.dart';
import 'package:medilink_app/screens/radiographie/edit_radiographie/components/edit_form.dart';
import 'package:medilink_app/utils/constants.dart';

class Body extends StatelessWidget {
  const Body({super.key, required this.userId, required this.radiographie});
  final String userId;
  final Radiographie radiographie;

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
              title: "Edit Radiographie",
            ),
            const SizedBox(
              height: 26,
            ),
            EditRadioForm(radiographie: radiographie, userId: userId),
          ],
        ),
      ),
    );
  }
}
