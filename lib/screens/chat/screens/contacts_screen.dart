import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilink_app/components/custom_app_bar.dart';
import 'package:medilink_app/components/custom_search_bar.dart';
import 'package:medilink_app/navigation/patient/patient_navigation_controller.dart';
import 'package:medilink_app/utils/constants.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PatientNavigationController patientNavigationController =
        Get.put(PatientNavigationController());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            right: defaultScreenPadding,
            left: defaultScreenPadding,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: defaultScreenPadding,
                ),
                CustomAppBar(
                  title: "New Message",
                  onBack: () {
                    patientNavigationController.updateCurrentChatPage(0);
                  },
                ),
                const SizedBox(
                  height: 26,
                ),
                const CustomSearchBar(
                  searchText: "Search Contact",
                  withFilteringBadge: true,
                ),
                const SizedBox(
                  height: 26,
                ),
                Text(
                  "All contacts",
                  style: GoogleFonts.nunitoSans(
                    fontSize: 16,
                    color: typingColor.withOpacity(0.60),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                /*SizedBox(
                  child: ListView.builder(
                    itemCount: doctors.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final doctor = doctors[index];
                      return ContactCard(
                        index: index,
                        doctor: doctor,
                        onTap: () => Get.to(ChatScreen(conv: doctor)),
                      );
                    },
                  ),
                )
              */
              ],
            ),
          ),
        ),
      ),
    );
  }
}
