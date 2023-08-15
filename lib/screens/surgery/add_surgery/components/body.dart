import 'package:flutter/material.dart';
import 'package:medilink_app/components/custom_app_bar.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/screens/surgery/add_surgery/components/add_surgery_form.dart';
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
              title: "Add Surgery",
            ),
            const SizedBox(
              height: 26,
            ),
            AddSurgerieForm(user: user, userId: userId),
          ],
        ),
      ),
    );
  }
}
