import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:medilink_app/components/custom_app_bar.dart';
import 'package:medilink_app/navigation/patient/patient_navigation_controller.dart';
import 'package:medilink_app/screens/home/home_controller.dart';
import 'package:medilink_app/utils/constants.dart';

class PatientProfile extends StatefulWidget {
  const PatientProfile({super.key});

  @override
  State<PatientProfile> createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  bool showPersonalInfo = false;
  bool showMedicalFolder = false;
  DateTime currentDate = DateTime.now();

  String convertDate(DateTime birthday) {
    String formattedBirthday = DateFormat('yyyy-MM-dd').format(birthday);

    return formattedBirthday;
  }

  PatientNavigationController patientNavigationController =
      Get.put(PatientNavigationController());

  @override
  Widget build(BuildContext context) {
    HomeData controller = Get.put(HomeData());
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: defaultScreenPadding,
          vertical: defaultScreenPadding,
        ),
        child: Column(
          children: [
            CustomAppBar(
              title: "",
            ),
            SizedBox(
              height: 26.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  maxRadius: 80.w,
                  backgroundImage:
                      CachedNetworkImageProvider(controller.user.picture!),
                ),
              ],
            ),
            SizedBox(
              height: 26.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${controller.user.firstname} ${controller.user.lastname}",
                  style: GoogleFonts.nunitoSans(
                    fontSize: 24.sp,
                    color: typingColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  width: 16.w,
                ),
                GestureDetector(
                  onTap: () {
                    patientNavigationController.updateCurrentProfilePage(1);
                  },
                  child: ImageIcon(
                    AssetImage("assets/icons/edit-text.png"),
                    color: typingColor.withOpacity(0.50),
                    size: 26.sp,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 36.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              width: MediaQuery.of(context).size.width,
              height: 70.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50.w,
                        height: 50.h,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: lightBlueColor,
                          borderRadius: showPersonalInfo
                              ? BorderRadius.only(
                                  topLeft: Radius.circular(12.r),
                                  topRight: Radius.circular(12.r),
                                )
                              : BorderRadius.all(
                                  Radius.circular(12.r),
                                ),
                        ),
                        child: ImageIcon(
                          AssetImage("assets/icons/avatar.png"),
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      Text(
                        "Personal Informations",
                        style: GoogleFonts.nunitoSans(
                          color: typingColor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showPersonalInfo = !showPersonalInfo;
                      });
                    },
                    child: Container(
                      width: 50.w,
                      height: 50.h,
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: lightBlueColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.r),
                        ),
                      ),
                      child: ImageIcon(
                        showPersonalInfo
                            ? AssetImage("assets/icons/arrow-up.png")
                            : AssetImage("assets/icons/down.png"),
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: showPersonalInfo,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12.r),
                    bottomRight: Radius.circular(12.r),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50.w,
                          height: 50.h,
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: lightBlueColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.r),
                            ),
                          ),
                          child: ImageIcon(
                            AssetImage("assets/icons/telephone.png"),
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        Text(
                          controller.user.phoneNumber ?? "",
                          style: GoogleFonts.nunitoSans(
                            color: typingColor,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 50.w,
                          height: 50.h,
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: lightBlueColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.r),
                            ),
                          ),
                          child: ImageIcon(
                            AssetImage("assets/icons/mail_5.png"),
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        Text(
                          controller.user.email,
                          style: GoogleFonts.nunitoSans(
                            color: typingColor,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 50.w,
                          height: 50.h,
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: lightBlueColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.r),
                            ),
                          ),
                          child: ImageIcon(
                            AssetImage("assets/icons/calendar.png"),
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        Text(
                          convertDate(controller.user.dateOfBirth!),
                          style: GoogleFonts.nunitoSans(
                            color: typingColor,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            GestureDetector(
              onTap: () {
                patientNavigationController.updateCurrentPage(2);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                width: MediaQuery.of(context).size.width,
                height: 70.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.r),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50.w,
                      height: 50,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: lightBlueColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      child: ImageIcon(
                        AssetImage("assets/icons/medical-file.png"),
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      "Medical Folder",
                      style: GoogleFonts.nunitoSans(
                        color: typingColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              width: MediaQuery.of(context).size.width,
              height: 70.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: lightBlueColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    child: ImageIcon(
                      AssetImage("assets/icons/language.png"),
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    "Languages",
                    style: GoogleFonts.nunitoSans(
                      color: typingColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              width: MediaQuery.of(context).size.width,
              height: 70.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: lightBlueColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    child: ImageIcon(
                      AssetImage("assets/icons/logout.png"),
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    "Log Out",
                    style: GoogleFonts.nunitoSans(
                      color: typingColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}