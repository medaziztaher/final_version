import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink_app/components/custom_app_bar.dart';
import 'package:medilink_app/components/custom_search_bar.dart';
import 'package:medilink_app/components/custom_sepeciality_card.dart';
import 'package:medilink_app/navigation/patient/patient_navigation_controller.dart';
import 'package:medilink_app/utils/constants.dart';

class SpecialitesScreen extends StatelessWidget {
  const SpecialitesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PatientNavigationController patientNavigationController =
        Get.put(PatientNavigationController());
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: defaultScreenPadding,
          right: defaultScreenPadding,
          left: defaultScreenPadding,
        ),
        child: Column(
          children: [
            CustomAppBar(
                title: "All specialists",
                onBack: () {
                  if (patientNavigationController.previousDoctorPage == 1) {
                    patientNavigationController.updatePreviousDoctorPage(
                      patientNavigationController.previousDoctorPage - 1,
                    );
                  }

                  patientNavigationController.updateCurrentDoctorPage(
                      patientNavigationController.previousDoctorPage);
                }),
            const SizedBox(
              height: 26,
            ),
            const CustomSearchBar(
              searchText: "Search Speciality",
              withFilteringBadge: true,
            ),
            const SizedBox(
              height: 26,
            ),
            Wrap(
              alignment: WrapAlignment.start,
              spacing: 22,
              runSpacing: 22.0,
              children: List.generate(
                specialistes.length,
                (index) => SpecialityCard(
                  index: index,
                  item: specialistes[index],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
