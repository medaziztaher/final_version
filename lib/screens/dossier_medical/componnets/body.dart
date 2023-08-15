import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/screens/allergie/user_allergie/user_allergies_screen.dart';
import 'package:medilink_app/screens/analyse/user_analyse/user_analyse_screen.dart';
import 'package:medilink_app/screens/disease/user_deseases/user_deseases_screen.dart';
import 'package:medilink_app/screens/dossier_medical/componnets/add_medical_files.dart';
import 'package:medilink_app/screens/dossier_medical/componnets/dossier_medical_menu.dart';
import 'package:medilink_app/screens/emergency_contact/get_emergency_conatct/get_emergency_contact.dart';
import 'package:medilink_app/screens/healthMetrics/components/all_user_metrics.dart';
import 'package:medilink_app/screens/notification/notification_screen.dart';
import 'package:medilink_app/screens/prescriptions/user_presc/user_presc_screen.dart';
import 'package:medilink_app/screens/radiographie/user_radiographies/user_radiographie_screen.dart';
import 'package:medilink_app/screens/surgery/user_surgery/user_surgery_screen.dart';
import 'package:medilink_app/utils/constants.dart';

class Body extends StatelessWidget {
  const Body({super.key, required this.user, required this.userId});
  final User user;
  final String? userId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: defaultScreenPadding,
          right: defaultScreenPadding,
          left: defaultScreenPadding,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                user.id == userId
                    ? Text(
                        "Your Medical Folder",
                        style: GoogleFonts.nunitoSans(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: typingColor,
                        ),
                      )
                    : Text('${user.name} Medical Folder'),
                InkWell(
                  onTap: () {
                    Get.to(NotificationScreen());
                  },
                  child: Container(
                    width: 42,
                    height: 42,
                    padding: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(84, 228, 226, 226),
                          blurRadius: 15.0, // soften the shadow
                          spreadRadius: 3.0, //extend the shadow
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(14),
                      ),
                    ),
                    child: const ImageIcon(
                      AssetImage("assets/icons/bell-ring.png"),
                      color: typingColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 26,
            ),
            addMedicalFile(),
            ProfileMenu(
              text: "Health Metrics",
              icon: "assets/icons/medical-check.png",
              press: () => Get.to(() => UserMetrics(user: user)),
            ),
            ProfileMenu(
              text: "Allergies",
              icon: "assets/icons/allergies.png",
              press: () => Get.to(() => UserAllergeyScreen(user: user)),
            ),
            ProfileMenu(
              text: "Diseases",
              icon: "assets/icons/diseases.png",
              press: () => Get.to(() => UserDiseaseScreen(
                    user: user,
                  )),
            ),
            ProfileMenu(
              text: "Prescrptions",
              icon: "assets/icons/medications.png",
              press: () => Get.to(() => UserPrescScreen(
                    user: user,
                  )),
            ),
            ProfileMenu(
              text: "Radiographies",
              icon: "assets/icons/radiography.png",
              press: () => Get.to(() => UserRadioScreen(user: user)),
            ),
            ProfileMenu(
              text: "Analyses",
              icon: "assets/icons/analyses.png",
              press: () => Get.to(() => UserAnalyseScreen(user: user)),
            ),
            ProfileMenu(
              text: "Surgeries",
              icon: "assets/icons/surgeon.png",
              press: () => Get.to(() => UserSurgeriesScreen(user: user)),
            ),
            ProfileMenu(
              text: "Emergency Contacts",
              icon: "assets/icons/ambulance.png",
              press: () => Get.to(() => UserEmergencyContact(user: user)),
            ),
          ],
        ),
      ),
    );
  }

  Padding addMedicalFile() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(96, 171, 182, 234),
              blurRadius: 6.0, // soften the shadow
              spreadRadius: 0.0, //extend the shadow
            )
          ],
        ),
        child: TextButton(
          style: TextButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            backgroundColor: Colors.white,
          ),
          onPressed: () {
            Get.to(() => AddMedicalFiles(user: user, userId: userId));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 4,
              vertical: 12,
            ),
            child: Row(
              children: [
                Image.asset(
                  "assets/icons/medical-records.png",
                  width: 44,
                ),
                const SizedBox(width: 20),
                Expanded(
                    child: Text(
                  "Add Medical Files",
                  style: GoogleFonts.nunitoSans(
                    color: typingColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                )),
                const ImageIcon(
                  AssetImage("assets/icons/add-button.png"),
                  size: 33,
                  color: typingColor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
