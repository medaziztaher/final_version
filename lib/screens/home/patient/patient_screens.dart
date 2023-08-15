import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink_app/navigation/patient/patient_navigation_controller.dart';
import 'package:medilink_app/screens/chat/screens/contacts_screen.dart';
import 'package:medilink_app/screens/chat/screens/messages_screen.dart';
import 'package:medilink_app/screens/dossier_medical/dossier_medicale_screen.dart';
import 'package:medilink_app/screens/home/home_controller.dart';
import 'package:medilink_app/screens/home/patient/patient_home_screen.dart';
import 'package:medilink_app/screens/prescriptions/add_presc/add_presc_screen.dart';
import 'package:medilink_app/screens/prescriptions/prescriptions_screen.dart';
import 'package:medilink_app/screens/profile/healthcare_provider_profile/profile_screen.dart';
import 'package:medilink_app/screens/profile/patient/update_patient_profile.dart';
import 'package:medilink_app/screens/profile/profile_screen.dart';
import 'package:medilink_app/screens/search/search_doctor/search_doctors_home_screen.dart';
import 'package:medilink_app/screens/search/search_doctor/search_doctors_screen.dart';
import 'package:medilink_app/screens/search/search_doctor/specialites_screen.dart';
import 'package:medilink_app/utils/constants.dart';

class PatientScreens extends StatelessWidget {
  const PatientScreens({super.key});

  @override
  Widget build(BuildContext context) {
    HomeData homeController = Get.put(HomeData());
    List screens = [
      const HomeNavigation(),
      const SearchDoctorsNavigations(),
      DossierMedicaleScreen(
        user: homeController.user,
      ),
      const ChatNavigations(),
      const ProfileNavigations(),
    ];

    PatientNavigationController navigationController =
        Get.put(PatientNavigationController());

    return GetBuilder<PatientNavigationController>(builder: (controller) {
      return Scaffold(
          bottomNavigationBar: Container(
            height: 75,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(84, 228, 226, 226),
                  blurRadius: 15.0, // soften the shadow
                  spreadRadius: 4.0, //extend the shadow
                )
              ],
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  color: Colors.white,
                  enableFeedback: false,
                  onPressed: () {
                    navigationController.updateCurrentPage(0);
                  },
                  icon: navigationController.currentPage == 0
                      ? Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                16,
                              ),
                            ),
                          ),
                          child: const ImageIcon(
                            AssetImage(
                              "assets/icons/home-full.png",
                            ),
                            color: primaryColor,
                          ),
                        )
                      : const ImageIcon(
                          AssetImage(
                            "assets/icons/home-full.png",
                          ),
                          color: lightGreyColor,
                        ),
                ),
                IconButton(
                  color: Colors.white,
                  enableFeedback: false,
                  onPressed: () {
                    navigationController.updateCurrentPage(1);
                  },
                  icon: navigationController.currentPage == 1
                      ? Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                16,
                              ),
                            ),
                          ),
                          child: const ImageIcon(
                            AssetImage(
                              "assets/icons/doctor.png",
                            ),
                            color: primaryColor,
                          ),
                        )
                      : const ImageIcon(
                          AssetImage(
                            "assets/icons/doctor.png",
                          ),
                          color: lightGreyColor,
                        ),
                ),
                IconButton(
                  color: Colors.white,
                  enableFeedback: false,
                  onPressed: () {
                    navigationController.updateCurrentPage(2);
                  },
                  icon: navigationController.currentPage == 2
                      ? Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                16,
                              ),
                            ),
                          ),
                          child: const ImageIcon(
                            AssetImage(
                              "assets/icons/medical-file.png",
                            ),
                            color: primaryColor,
                          ),
                        )
                      : const ImageIcon(
                          AssetImage(
                            "assets/icons/medical-file.png",
                          ),
                          color: lightGreyColor,
                        ),
                ),
                IconButton(
                  color: Colors.white,
                  enableFeedback: false,
                  onPressed: () {
                    navigationController.updateCurrentPage(3);
                  },
                  icon: navigationController.currentPage == 3
                      ? Container(
                          decoration: const BoxDecoration(
                            color: lightBlueColor,
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  16,
                                ),
                              ),
                            ),
                            child: const ImageIcon(
                              AssetImage(
                                "assets/icons/chat.png",
                              ),
                              color: primaryColor,
                            ),
                          ),
                        )
                      : const ImageIcon(
                          AssetImage(
                            "assets/icons/chat.png",
                          ),
                          color: lightGreyColor,
                        ),
                ),
                IconButton(
                  color: Colors.white,
                  enableFeedback: false,
                  onPressed: () {
                    navigationController.updateCurrentPage(4);
                  },
                  icon: navigationController.currentPage == 4
                      ? Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                16,
                              ),
                            ),
                          ),
                          child: const ImageIcon(
                            AssetImage(
                              "assets/icons/avatar.png",
                            ),
                            color: primaryColor,
                          ),
                        )
                      : const ImageIcon(
                          AssetImage(
                            "assets/icons/avatar.png",
                          ),
                          color: lightGreyColor,
                        ),
                ),
              ],
            ),
          ),
          body: screens[navigationController.currentPage]);
    });
  }
}

class HomeNavigation extends StatefulWidget {
  const HomeNavigation({super.key});

  @override
  State<HomeNavigation> createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {
  PatientNavigationController patientNavigationController =
      Get.put(PatientNavigationController());

  List patientHomeScreens = [
    const PatientHomeScreen(),
    const PrescriptionsScreen(),
    const AddPrescrptionScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PatientNavigationController>(builder: (controller) {
      return Scaffold(
        body: patientHomeScreens[controller.currentHomePage],
      );
    });
  }
}

class SearchDoctorsNavigations extends StatefulWidget {
  const SearchDoctorsNavigations({super.key});

  @override
  State<SearchDoctorsNavigations> createState() =>
      _SearchDoctorsNavigationsState();
}

class _SearchDoctorsNavigationsState extends State<SearchDoctorsNavigations> {
  PatientNavigationController patientNavigationController =
      Get.put(PatientNavigationController());

  List searchDoctorsScreens = [
    const SearchDoctorsHomeScreen(),
    const HealthcareProviderProfileScreen(),
    const SpecialitesScreen(),
    const SearchDoctorsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PatientNavigationController>(builder: (controller) {
      return Scaffold(
        body: searchDoctorsScreens[controller.currentDoctorPage],
      );
    });
  }
}

class ChatNavigations extends StatefulWidget {
  const ChatNavigations({super.key});

  @override
  State<ChatNavigations> createState() => _ChatNavigationsState();
}

class _ChatNavigationsState extends State<ChatNavigations> {
  PatientNavigationController patientNavigationController =
      Get.put(PatientNavigationController());

  List patientChatScreens = [
    const MessagesScreen(),
    const ContactsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PatientNavigationController>(builder: (controller) {
      return Scaffold(
        body: patientChatScreens[controller.currentChatPage],
      );
    });
  }
}

class ProfileNavigations extends StatefulWidget {
  const ProfileNavigations({super.key});

  @override
  State<ProfileNavigations> createState() => _ProfileNavigationsState();
}

class _ProfileNavigationsState extends State<ProfileNavigations> {
  PatientNavigationController patientNavigationController =
      Get.put(PatientNavigationController());

  List patientProfileScreens = [
    const ProfileScreen(),
    const UpdatePatientProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PatientNavigationController>(builder: (controller) {
      return Scaffold(
        body: patientProfileScreens[controller.currentProfilePage],
      );
    });
  }
}
