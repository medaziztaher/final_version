import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink_app/api/global.dart';
import 'package:medilink_app/screens/home/home_controller.dart';
import 'package:medilink_app/screens/prescriptions/add_presc/components/body.dart';
import 'package:medilink_app/utils/constants.dart';


class AddPrescrptionScreen extends StatefulWidget {
  const AddPrescrptionScreen({super.key});

  @override
  State<AddPrescrptionScreen> createState() => _AddPrescrptionScreenState();
}

class _AddPrescrptionScreenState extends State<AddPrescrptionScreen> {
  


  @override
  Widget build(BuildContext context) {
    HomeData homeController = Get.put(HomeData());

    return Scaffold(
      body: FutureBuilder<String?>(
        future: getUserId(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: primaryColor));
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final userId = snapshot.data!;
            return Body(user: homeController.user, userId: userId);
          }
        },
      ),
    );
  }
}
