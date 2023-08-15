import 'package:flutter/material.dart';
import 'package:medilink_app/components/custom_app_bar.dart';
import 'package:medilink_app/models/surgery.dart';
import 'package:medilink_app/screens/surgery/edit_surgery/components/edit_surgerie_form.dart';
import 'package:medilink_app/utils/constants.dart';

class Body extends StatelessWidget {
  const Body({
    super.key,
    required this.userId,
    required this.surgerie,
  });
  final String userId;
  final Surgery surgerie;

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
              title: "Edit Surgery",
            ),
            const SizedBox(
              height: 26,
            ),
            EditSurgerieForm(surgerie: surgerie, userId: userId),
          ],
        ),
      ),
    );
  }
}
