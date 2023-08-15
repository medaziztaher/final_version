
import 'package:flutter/material.dart';
import 'package:medilink_app/api/global.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/screens/surgery/user_surgery/components/body.dart';

class UserSurgeriesScreen extends StatefulWidget {
  const UserSurgeriesScreen({super.key, required this.user});
  final User user;

  @override
  State<UserSurgeriesScreen> createState() => _UserSurgeriesScreenState();
}

class _UserSurgeriesScreenState extends State<UserSurgeriesScreen> {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: FutureBuilder<String?>(
          future: getUserId(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading...");
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              final userId = snapshot.data;
              if (userId == widget.user.id) {
                return const Text("Surgeries");
              } else {
                return Text("${widget.user.name} Surgeries");
              }
            }
          },
        ),
      ),
      body: FutureBuilder<String?>(
        future: getUserId(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final userId = snapshot.data;
            return Body(user: widget.user, userId: userId);
          }
        },
      ),
    );
  }
}
