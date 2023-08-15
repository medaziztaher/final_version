import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:medilink_app/components/custom_app_bar.dart';
import 'package:medilink_app/models/prescription.dart';
import 'package:medilink_app/navigation/patient/patient_navigation_controller.dart';
import 'package:medilink_app/screens/prescriptions/add_presc/components/date_timeline_picker.dart';
import 'package:medilink_app/screens/prescriptions/add_presc/components/greeting.dart';
import 'package:medilink_app/screens/prescriptions/add_presc/components/upcoming_prescription_card.dart';
import 'package:medilink_app/utils/constants.dart';

class PrescriptionsScreen extends StatelessWidget {
  const PrescriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PatientNavigationController patientNavigationController =
        Get.put(PatientNavigationController());

    DateTime currentDate = DateTime.now();
    // Convert string to DateTime object
    DateTime dateObj =
        DateFormat("yyyy-MM-dd HH:mm:ss.SSS").parse(currentDate.toString());

    // Get weekday name and month name from DateTime object
    String weekdayName = DateFormat.EEEE().format(dateObj);
    String monthName = DateFormat.MMMM().format(dateObj);

    // Determine morning or evening based on hour
    int hour = dateObj.hour;
    String timeOfDay = hour <= 12 ? "Morning" : "Evening";

    // Construct final formatted string
    String formattedStr = "$weekdayName ${dateObj.day} $monthName";

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: const ImageIcon(
          AssetImage("assets/icons/add.png"),
          size: 36,
          color: Colors.white,
        ),
        onPressed: () {
          patientNavigationController.updatePreviousHomePage(
              patientNavigationController.currentHomePage);
          patientNavigationController.updateCurrentHomePage(2);
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: defaultScreenPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: defaultScreenPadding,
                  ),
                  child: CustomAppBar(
                      title: "Medications",
                      onBack: () {
                        if (patientNavigationController.previousHomePage == 1) {
                          patientNavigationController.updatePreviousHomePage(
                            patientNavigationController.previousHomePage - 1,
                          );
                        }

                        patientNavigationController.updateCurrentHomePage(
                            patientNavigationController.previousHomePage);
                      })),
              SizedBox(
                height: 26.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: DateTimelinePicker(),
              ),
              SizedBox(
                height: 22.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultScreenPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Today",
                      style: GoogleFonts.nunitoSans(
                          fontSize: 16.sp,
                          color: typingColor.withOpacity(0.65)),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Text(
                      formattedStr,
                      style: GoogleFonts.nunitoSans(
                        color: typingColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 326.h,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(84, 228, 226, 226),
                            blurRadius: 15.0, // soften the shadow
                            spreadRadius: 0.0, //extend the shadow
                          ),
                        ],
                      ),
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                            left: 16,
                            right: 16,
                          ),
                          child: greeting(timeOfDay),
                        ),
                        Flexible(
                          child: SizedBox(
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: upcomingPills.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return UpcomingPrescriptionCard(
                                    medication: upcomingPills[index]);
                              },
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}