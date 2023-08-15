import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink_app/components/custom_app_bar.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/screens/allergie/add_allergie/add_allergie.dart';
import 'package:medilink_app/screens/analyse/add_analyse/add_analyse_screen.dart';
import 'package:medilink_app/screens/disease/add_desease/add_desease_screen.dart';
import 'package:medilink_app/screens/dossier_medical/componnets/dossier_medical_menu.dart';
import 'package:medilink_app/screens/prescriptions/add_presc/add_presc_screen.dart';
import 'package:medilink_app/screens/radiographie/add_radiographie/add_radiographie_screen.dart';
import 'package:medilink_app/screens/surgery/add_surgery/add_surgery_screen.dart';
import 'package:medilink_app/utils/constants.dart';

class AddMedicalFiles extends StatelessWidget {
  const AddMedicalFiles({super.key, required this.user, required this.userId});
  final User user;
  final String? userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            top: defaultScreenPadding,
            right: defaultScreenPadding,
            left: defaultScreenPadding,
          ),
          child: Column(
            children: [
              const CustomAppBar(
                title: "Add Medical Files",
              ),
              const SizedBox(
                height: 26,
              ),
              if (userId == user.id) ...[
                ProfileMenu(
                  text: "Add Allergies",
                  icon: "assets/icons/allergies.png",
                  press: () => Get.to(() => AddAllergyScreen(user: user)),
                ),
                ProfileMenu(
                  text: "Add Diseases",
                  icon: "assets/icons/diseases.png",
                  press: () => Get.to(() => AddDiseaseScreen(
                        user: user,
                      )),
                ),
                ProfileMenu(
                  text: "Add Radiographies",
                  icon: "assets/icons/radiography.png",
                  press: () => Get.to(() => AddRadiographieScreen(user: user)),
                ),
                ProfileMenu(
                  text: "Add Analyses",
                  icon: "assets/icons/analyses.png",
                  press: () => Get.to(() => AddAnalyseScreen(user: user)),
                ),
              ],
              ProfileMenu(
                text: "Add Prescrptions",
                icon: "assets/icons/medications.png",
                press: () => Get.to(const AddPrescrptionScreen()),
              ),
              ProfileMenu(
                text: "Add Surgeries",
                icon: "assets/icons/surgeon.png",
                press: () => Get.to(() => AddSurgerirScreen(user: user)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
