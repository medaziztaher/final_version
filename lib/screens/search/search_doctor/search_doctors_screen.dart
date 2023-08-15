import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/components/custom_app_bar.dart';
import 'package:medilink_app/components/custom_doctor_card.dart';
import 'package:medilink_app/components/custom_search_bar.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/navigation/patient/patient_navigation_controller.dart';
import 'package:medilink_app/screens/home/home_controller.dart';
import 'package:medilink_app/settings/networkhandler.dart';
import 'package:medilink_app/utils/constants.dart';

class SearchDoctorsScreen extends StatefulWidget {
  const SearchDoctorsScreen({super.key});

  @override
  State<SearchDoctorsScreen> createState() => _SearchDoctorsScreenState();
}

class _SearchDoctorsScreenState extends State<SearchDoctorsScreen> {
  bool isLoading = false;
  NetworkHandler networkHandler = NetworkHandler();
  HomeData homeController = Get.put(HomeData());

  Future<List<User>> getListofDoctors() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await networkHandler
          .get('$patientUri/${homeController.user.id}/doctors');
      if (response.statusCode == 200) {
        List<dynamic> data =
            json.decode(response.body)['data'] as List<dynamic>;
        List<User> newusers = data.map((item) => User.fromJson(item)).toList();
        return newusers;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      throw e;
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

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
                child: FutureBuilder(
                    future: getListofDoctors(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text("No doctor found"),
                        );
                      } else {
                        final users = snapshot.data!;
                        return ListView.builder(
                          itemCount: users.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final doctor = users[index];
                            return DoctorCard(
                              index: index,
                              doctor: doctor,
                            );
                          },
                        );
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
