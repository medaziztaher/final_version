import 'package:flutter/material.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/screens/allergie/add_allergie/components/body.dart';

class AddAllergyScreen extends StatelessWidget {
  const AddAllergyScreen({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(user:user),
    );
  }
}
