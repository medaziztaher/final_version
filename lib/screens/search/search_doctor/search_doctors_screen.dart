import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink_app/components/custom_app_bar.dart';
import 'package:medilink_app/components/custom_doctor_card.dart';
import 'package:medilink_app/components/custom_search_bar.dart';
import 'package:medilink_app/navigation/patient/patient_navigation_controller.dart';
import 'package:medilink_app/utils/constants.dart';


class SearchDoctorsScreen extends StatelessWidget {
  const SearchDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PatientNavigationController patientNavigationController =
        Get.put(PatientNavigationController());
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          top: defaultScreenPadding,
          right: defaultScreenPadding,
          left: defaultScreenPadding,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(
                title: "All Doctors",
                onBack: () {
                  patientNavigationController.updateCurrentDoctorPage(
                      patientNavigationController.previousDoctorPage);
                },
              ),
              const SizedBox(
                height: 26,
              ),
              const CustomSearchBar(
                searchText: "Search Doctors",
                withFilteringBadge: true,
              ),
              const SizedBox(
                height: 26,
              ),
              SizedBox(
                child: ListView.builder(
                  itemCount: doctors.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return DoctorCard(
                      index: index,
                      doctor: doctors[index],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
