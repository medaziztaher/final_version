import 'package:flutter/material.dart';
import 'package:medilink_app/api/global.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/screens/analyse/user_analyse/components/body.dart';
class UserAnalyseScreen extends StatefulWidget {
  const UserAnalyseScreen({super.key, required this.user});
  final User user;

  @override
  State<UserAnalyseScreen> createState() => _UserAnalyseScreenState();
}

class _UserAnalyseScreenState extends State<UserAnalyseScreen> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: FutureBuilder<String?>(
          future: getUserId(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading...");
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              final userId = snapshot.data;
              if (userId == widget.user.id) {
                return Text("Analyses");
              } else {
                return Text("${widget.user.name} Analyses");
              }
            }
          },
        ),
      ),
      body: FutureBuilder<String?>(
        future: getUserId(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
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
