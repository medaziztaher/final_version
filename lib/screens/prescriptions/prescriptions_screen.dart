import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:medilink_app/components/custom_app_bar.dart';
import 'package:medilink_app/navigation/patient/patient_navigation_controller.dart';
import 'package:medilink_app/screens/prescriptions/add_presc/components/greeting.dart';
import 'package:medilink_app/screens/prescriptions/add_presc/components/upcoming_prescription_card.dart';
import 'package:medilink_app/utils/constants.dart';

import 'prescription_controller.dart';

class PrescriptionsScreen extends StatelessWidget {
  const PrescriptionsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    PrescriptionController controller = Get.put(PrescriptionController());
    PatientNavigationController patientNavigationController =
        Get.put(PatientNavigationController());
    DateTime currentDate = DateTime.now();
    DateTime dateObj =
        DateFormat("yyyy-MM-dd HH:mm:ss.SSS").parse(currentDate.toString());
    String weekdayName = DateFormat.EEEE().format(dateObj);
    String monthName = DateFormat.MMMM().format(dateObj);
    int hour = dateObj.hour;
    String timeOfDay = hour <= 12 ? "Morning" : "Evening";
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
          padding: const EdgeInsets.symmetric(vertical: defaultScreenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: defaultScreenPadding),
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
                  },
                ),
              ),
              SizedBox(height: 26.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: CustomDateTimelinePicker(
                  onDateSelected: (selectedDate) {
                    controller.updateSelectedDate(selectedDate);
                  },
                ),
              ),
              SizedBox(height: 22.h),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: defaultScreenPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Today",
                      style: GoogleFonts.nunitoSans(
                        fontSize: 16.sp,
                        color: typingColor.withOpacity(0.65),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      formattedStr,
                      style: GoogleFonts.nunitoSans(
                        color: typingColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 326.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(84, 228, 226, 226),
                            blurRadius: 15.0,
                            spreadRadius: 0.0,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 16, right: 16),
                            child: greeting(timeOfDay),
                          ),
                          Flexible(
                            child: SizedBox(
                                child: Obx(
                              () => ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    controller.prescriptionsReminders.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return UpcomingPrescriptionCard(
                                    medication: controller
                                        .prescriptionsReminders[index],
                                  );
                                },
                              ),
                            )),
                          ),
                        ],
                      ),
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

// Define a callback type for when a date is selected
typedef OnDateSelectedCallback = void Function(DateTime selectedDate);

class CustomDateTimelinePicker extends StatelessWidget {
  final OnDateSelectedCallback? onDateSelected;

  const CustomDateTimelinePicker({super.key, this.onDateSelected});

  @override
  Widget build(BuildContext context) {
    return EasyDateTimeLine(
      initialDate: DateTime.now(),
      headerProps: EasyHeaderProps(
        selectedDateStyle: GoogleFonts.nunitoSans(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: typingColor,
        ),
        monthStyle: GoogleFonts.nunitoSans(
          color: typingColor,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      activeColor: primaryColor,
      dayProps: const EasyDayProps(
        dayStructure: DayStructure.dayStrDayNum,
        height: 66.0,
        width: 66.0,
        activeMothStrStyle: TextStyle(),
        activeDayNumStyle: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
        inactiveDayNumStyle: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: typingColor,
        ),
        inactiveDayStrStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: typingColor,
        ),
        activeDayStrStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        inactiveDayDecoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
      ),
      onDateChange: (selectedDate) {
        onDateSelected?.call(selectedDate);
      },
    );
  }
}
