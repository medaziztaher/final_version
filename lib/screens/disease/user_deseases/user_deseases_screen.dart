import 'package:flutter/material.dart';
import 'package:medilink_app/api/global.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/screens/disease/user_deseases/components/body.dart';

class UserDiseaseScreen extends StatefulWidget {
  const UserDiseaseScreen({super.key, required this.user});
  final User user;

  @override
  State<UserDiseaseScreen> createState() => _UserDiseaseScreenState();
}

class _UserDiseaseScreenState extends State<UserDiseaseScreen> {
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
                return const Text("Diseases");
              } else {
                return Text("${widget.user.name} Diseases");
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
