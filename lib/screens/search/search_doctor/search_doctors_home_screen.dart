import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilink_app/components/custom_doctor_card.dart';
import 'package:medilink_app/components/custom_search_bar.dart';
import 'package:medilink_app/components/custom_sepeciality_card.dart';
import 'package:medilink_app/components/section_devider.dart';
import 'package:medilink_app/navigation/patient/patient_navigation_controller.dart';
import 'package:medilink_app/screens/notification/notification_screen.dart';
import 'package:medilink_app/utils/constants.dart';

class SearchDoctorsHomeScreen extends StatefulWidget {
  const SearchDoctorsHomeScreen({super.key});

  @override
  State<SearchDoctorsHomeScreen> createState() =>
      _SearchDoctorsHomeScreenState();
}

class _SearchDoctorsHomeScreenState extends State<SearchDoctorsHomeScreen> {
  PatientNavigationController patientNavigationController =
      Get.put(PatientNavigationController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.only(
        right: defaultScreenPadding,
        left: defaultScreenPadding,
      ),
      child: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: defaultScreenPadding,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Let's Find you a specialist",
                style: GoogleFonts.nunitoSans(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: typingColor,
                ),
              ),
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
          const CustomSearchBar(
            searchText: "Search doctors, specialists..",
            withFilteringBadge: true,
          ),
          const SizedBox(
            height: 26,
          ),
          SectionDivider(
              sectionTitle: "Specialites",
              onTap: () {
                patientNavigationController.updatePreviousDoctorPage(
                    patientNavigationController.currentDoctorPage);

                patientNavigationController.updateCurrentDoctorPage(1);
              }),
          const SizedBox(
            height: 14,
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              itemCount: specialistes.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final item = specialistes[index];
                return GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: index == 0 ? 0 : defaultListViewItemsPadding,
                    ),
                    child: SpecialityCard(
                      index: index,
                      item: item,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 26,
          ),
          SectionDivider(
              sectionTitle: "Doctors",
              onTap: () {
                patientNavigationController.updatePreviousDoctorPage(
                    patientNavigationController.currentDoctorPage);

                patientNavigationController.updateCurrentDoctorPage(2);
              }),
          const SizedBox(
            height: 14,
          ),
          SizedBox(
            child: ListView.builder(
              itemCount: doctors.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final doctor = doctors[index];
                return DoctorCard(
                  index: index,
                  doctor: doctor,
                );
              },
            ),
          ),
        ]),
      ),
    ));
  }
}
