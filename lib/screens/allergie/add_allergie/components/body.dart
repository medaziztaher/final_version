import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink_app/components/custom_app_bar.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/screens/allergie/add_allergie/components/allergie_form.dart';
import 'package:medilink_app/utils/constants.dart';

class Body extends StatelessWidget {
  const Body({super.key, required this.user});
  final User user;
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
              title: "kaddallergie".tr,
            ),
            const SizedBox(
              height: 26,
            ),
            AddAllergieForm(user: user),
          ],
        ),
      ),
    );
  }
}
