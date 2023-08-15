import 'package:flutter/material.dart';
import 'package:medilink_app/components/custom_app_bar.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/screens/analyse/add_analyse/components/form.dart';
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
              title: "Add Analyses",
            ),
            const SizedBox(
              height: 26,
            ),
            AddAnalyseForm(user: user, userId: userId),
          ],
        ),
      ),
    );
  }
}
