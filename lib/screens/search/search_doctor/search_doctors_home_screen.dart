import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/components/custom_doctor_card.dart';
import 'package:medilink_app/components/custom_search_bar.dart';
import 'package:medilink_app/components/custom_sepeciality_card.dart';
import 'package:medilink_app/components/section_devider.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/navigation/patient/patient_navigation_controller.dart';
import 'package:medilink_app/screens/home/home_controller.dart';
import 'package:medilink_app/screens/notification/notification_screen.dart';
import 'package:medilink_app/settings/networkhandler.dart';
import 'package:medilink_app/utils/constants.dart';

class SearchDoctorsHomeScreen extends StatefulWidget {
  const SearchDoctorsHomeScreen({super.key});

  @override
  State<SearchDoctorsHomeScreen> createState() =>
      _SearchDoctorsHomeScreenState();
}

class _SearchDoctorsHomeScreenState extends State<SearchDoctorsHomeScreen> {
  bool isLoading = false;
  NetworkHandler networkHandler = NetworkHandler();
  String specialite = "";

  PatientNavigationController patientNavigationController =
      Get.put(PatientNavigationController());
  HomeData homeController = Get.put(HomeData());

  Future<List<User>> getdoctorsBySpecialite(specialite) async {
    try {
      final response = await networkHandler
          .get("$patientUri/${homeController.user.id}/doctors/$specialite");
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
    }
  }

  Future<List<User>> getListofDoctors() async {
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
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    await getListofDoctors();
    await getdoctorsBySpecialite(specialite);
  }

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
                  Get.to(const NotificationScreen());
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
                  onTap: () {
                    setState(() {
                      specialite = specialistes[index]['name'];
                      print(specialite);
                    });
                  },
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
            child: specialite.isNotEmpty
                ? FutureBuilder(
                    future: getdoctorsBySpecialite(specialite),
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
                          child: Text("No doctor found with this specialite"),
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
                    })
                : FutureBuilder(
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
          ),
        ]),
      ),
    ));
  }
}
