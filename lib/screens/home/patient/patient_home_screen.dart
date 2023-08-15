import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/components/custom_search_bar.dart';
import 'package:medilink_app/components/heading_doctor_card.dart';
import 'package:medilink_app/components/home_app_bar.dart';
import 'package:medilink_app/components/metric_card.dart';
import 'package:medilink_app/components/section_devider.dart';
import 'package:medilink_app/components/upcoming_medication.dart';
import 'package:medilink_app/models/health_metric.dart';
import 'package:medilink_app/models/reminder.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/navigation/patient/patient_navigation_controller.dart';
import 'package:medilink_app/screens/healthMetrics/health_metric_screen.dart';
import 'package:medilink_app/screens/home/home_controller.dart';
import 'package:medilink_app/screens/user/user_screen.dart';
import 'package:medilink_app/settings/networkhandler.dart';
import 'package:medilink_app/settings/realtime.dart';
import 'package:medilink_app/settings/shared_prefs.dart';
import 'package:medilink_app/utils/constants.dart';

class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({Key? key}) : super(key: key);

  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {
  bool isLoading = false;
  NetworkHandler networkHandler = NetworkHandler();
  final socket = SocketClient.instance.socket!;
  HomeData homeController = Get.put(HomeData());

  void _setupSocketListeners() {
    socket.on('followRequestError', (data) {
      if (mounted) {}
    });
    socket.on('followRequest', (data) {
      if (mounted) {
        _initializeUser();
      }
    });
    socket.on('followRequestReceived', (data) {
      if (mounted) {
        _initializeUser();
      }
    });
    socket.on('followRequestApproved', (data) {
      if (mounted) {
        _initializeUser();
      }
    });
    socket.on('followRequestdeclined', (data) {
      if (mounted) {
        _initializeUser();
      }
    });
    socket.on('declineRequestError', (data) {
      if (mounted) {
        _initializeUser();
      }
    });
    socket.on('approveRequestError', (data) {
      if (mounted) {
        _initializeUser();
      }
    });
    socket.on('unfollowSuccess', (data) {
      if (mounted) {
        _initializeUser();
      }
    });
    socket.on('cancelRequestSuccess', (data) {
      if (mounted) {
        _initializeUser();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeUser();
    _setupSocketListeners();
  }

  Future<List<Reminder>> getPatientReminder() async {
    try {
      final response = await networkHandler.get(
        "$prescriptionUri/reminders/${Pref().prefs!.getString(kuuid)}/${DateFormat("yyyy-MM-dd").format(DateTime.now())}",
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        final List<Reminder> reminders =
            data.map((item) => Reminder.fromJson(item)).toList();
        return reminders;
      } else {
        print(
            'API returned an error: ${json.decode(response.body)['message']}');
        return []; // Add this line to return an empty list in case of error
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<User>> getPatientDoctors() async {
    try {
      final response = await networkHandler.get(
          "$patientUri/${homeController.user.id}/healthcare-providers/Doctor");
      print(
          "response status : ${response.statusCode} // responseData : ${response.body} ");
      if (response.statusCode == 200) {
        List<dynamic> data =
            json.decode(response.body)['data'] as List<dynamic>;
        List<User> newusers = data.map((item) => User.fromJson(item)).toList();
        return newusers;
      } else {
        throw Exception('Failed to fetch healthcare providers');
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> _initializeUser() async {
    getPatientDoctors();
    getPatientReminder();
    // getAllMetric();
  }

  int selectedHealthMetrics = 0;

  @override
  Widget build(BuildContext context) {
    PatientNavigationController patientNavigationController =
        Get.put(PatientNavigationController());

    return Scaffold(
      backgroundColor: scaffoldColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            right: defaultScreenPadding,
            left: defaultScreenPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: defaultScreenPadding,
              ),
              const HomeAppBar(),
              const SizedBox(
                height: 30,
              ),
              const CustomSearchBar(searchText: "Search Doctors"),
              const SizedBox(
                height: 26,
              ),
              SectionDivider(
                sectionTitle: "Upcoming Pills",
                onTap: () => {
                  patientNavigationController.updatePreviousHomePage(
                      patientNavigationController.currentHomePage),
                  patientNavigationController.updateCurrentHomePage(1),
                },
              ),
              const SizedBox(
                height: 14,
              ),
              SizedBox(
                height: 150,
                child: FutureBuilder(
                    future: getPatientReminder(),
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
                          child: Text("You don't any medication to take"),
                        );
                      } else {
                        final presciptions = snapshot.data!;
                        return ListView.builder(
                          itemCount: presciptions.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final item = presciptions[index];
                            return Padding(
                              padding: EdgeInsets.only(
                                left: index == 0
                                    ? 0
                                    : defaultListViewItemsPadding,
                              ),
                              child: UpcomingMedicationCard(item: item),
                            );
                          },
                        );
                      }
                    }),
              ),
              const SizedBox(
                height: 26,
              ),
              Text(
                "Your Health",
                style: GoogleFonts.nunitoSans(
                  color: typingColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              SizedBox(
                height: 130,
                child: Obx(
                  () => homeController.healthMetrics.isNotEmpty
                      ? ListView.builder(
                          itemCount: homeController.healthMetrics.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final item =
                                homeController.healthMetrics[index] as Metric;
                            return GestureDetector(
                              onTap: () => Get.to(() => MetricScreen(
                                    metric: item,
                                  )),
                              child: MetricsCard(
                                index: index,
                                item: item,
                              ),
                            );
                          },
                        )
                      : ListView.builder(
                          itemCount: health.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final item = health[index];
                            return GestureDetector(
                              onTap: () => Get.to(() => MetricScreen(
                                    metric: item,
                                  )),
                              child: MetricsCard(
                                index: index,
                                item: item,
                              ),
                            );
                          },
                        ),
                ),
              ),
              const SizedBox(
                height: 26,
              ),
              SectionDivider(
                sectionTitle: "Your Doctors",
                onTap: () {
                  // controller.updateCurrentPage(1);
                  // controller.updateCurrentDoctorPage(2);
                },
              ),
              const SizedBox(
                height: 14,
              ),
              SizedBox(
                height: 192,
                child: FutureBuilder<List<User>>(
                  future: getPatientDoctors(),
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
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("You don't have doctors"),
                            const SizedBox(height: 15),
                            ElevatedButton(
                              child: const Text('Add Doctors'),
                              onPressed: () {
                                // Handle the onPressed action here
                              },
                            ),
                          ],
                        ),
                      );
                    } else {
                      final users = snapshot.data!;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final user = users[index];
                          return Padding(
                            padding: EdgeInsets.only(
                              left:
                                  index == 0 ? 0 : defaultListViewItemsPadding,
                            ),
                            child: GestureDetector(
                                onTap: () => Get.to(() => UserScreen(
                                      userId: user.id,
                                    )),
                                child: HeadingDoctorCard(doctor: user)),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 26,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
