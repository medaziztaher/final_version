import 'package:flutter/material.dart';
import 'package:medilink_app/api/global.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/screens/dossier_medical/componnets/body.dart';
import 'package:medilink_app/utils/constants.dart';

class DossierMedicaleScreen extends StatefulWidget {
  const DossierMedicaleScreen({super.key, required this.user});
  final User user;
  @override
  State<DossierMedicaleScreen> createState() => _DossierMedicaleScreenState();
}

class _DossierMedicaleScreenState extends State<DossierMedicaleScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: getUserId(), // Use _userId directly
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: primaryColor,
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else {
          final userId = snapshot.data;
          return Body(user: widget.user, userId: userId);
        }
      },
    );
  }
}
