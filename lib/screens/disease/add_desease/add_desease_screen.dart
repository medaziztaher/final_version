import 'package:flutter/material.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/screens/disease/add_desease/components/body.dart';

class AddDiseaseScreen extends StatelessWidget {
  const AddDiseaseScreen({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(user: user),
    );
  }
}
