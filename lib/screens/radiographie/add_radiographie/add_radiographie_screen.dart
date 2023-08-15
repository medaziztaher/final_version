import 'package:flutter/material.dart';
import 'package:medilink_app/api/global.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/screens/radiographie/add_radiographie/components/body.dart';
import 'package:medilink_app/utils/constants.dart';

class AddRadiographieScreen extends StatefulWidget {
  const AddRadiographieScreen({super.key, required this.user});
  final User user;

  @override
  State<AddRadiographieScreen> createState() => _AddRadiographieScreenState();
}

class _AddRadiographieScreenState extends State<AddRadiographieScreen> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<String?>(
        future: getUserId(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: primaryColor,
            ));
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final userId = snapshot.data!;
            return Body(user: widget.user, userId: userId);
          }
        },
      ),
    );
  }
}
