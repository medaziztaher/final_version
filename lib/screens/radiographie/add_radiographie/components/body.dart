import 'package:flutter/material.dart';
import 'package:medilink_app/components/custom_app_bar.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/screens/radiographie/add_radiographie/components/add_radiographie_form.dart';
import 'package:medilink_app/utils/constants.dart';

class Body extends StatelessWidget {
  const Body({super.key, required this.user, required this.userId});
  final User user;
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
              title: "Add Radiographie",
            ),
            const SizedBox(
              height: 26,
            ),
            AddRadioForm(user: user, userId: userId),
          ],
        ),
      ),
    );
  }
}
