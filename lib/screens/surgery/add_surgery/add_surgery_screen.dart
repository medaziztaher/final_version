import 'package:flutter/material.dart';
import 'package:medilink_app/api/global.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/screens/surgery/add_surgery/components/body.dart';
import 'package:medilink_app/utils/constants.dart';

class AddSurgerirScreen extends StatefulWidget {
  const AddSurgerirScreen({super.key, required this.user});
  final User user;

  @override
  State<AddSurgerirScreen> createState() => _AddSurgerirScreenState();
}

class _AddSurgerirScreenState extends State<AddSurgerirScreen> {
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
