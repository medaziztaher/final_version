import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilink_app/components/custom_app_bar.dart';
import 'package:medilink_app/navigation/patient/patient_navigation_controller.dart';
import 'package:medilink_app/screens/profile/healthcare_provider_profile/profile_controller.dart';
import 'package:medilink_app/utils/constants.dart';

class HealthcareProviderProfileScreen extends StatelessWidget {
  const HealthcareProviderProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PatientNavigationController patientNavigationController =
        Get.put(PatientNavigationController());

    return GetBuilder(
        init: DoctorProfileController(),
        builder: (controller) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                      color: lightBlueColor,
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 36.h),
                          child: Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                              controller.doctor.picture!,
                              width: 200.w,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(
                              top: defaultScreenPadding * 1.75,
                              left: defaultScreenPadding,
                              right: defaultScreenPadding,
                            ),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(36.r),
                                topRight: Radius.circular(36.r),
                              ),
                              color: scaffoldColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${controller.doctor.firstname} ${controller.doctor.lastname}",
                                          style: GoogleFonts.nunitoSans(
                                              color: typingColor,
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(height: 6.h),
                                        Text(
                                          controller.doctor.speciality
                                              .toString(),
                                          style: GoogleFonts.nunitoSans(
                                              color:
                                                  typingColor.withOpacity(0.75),
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(height: 12.h),
                                        Row(
                                          children: [
                                            const ImageIcon(
                                              AssetImage(
                                                  "assets/icons/location.png"),
                                              color: primaryColor,
                                              size: 30,
                                            ),
                                            SizedBox(
                                              width: 6.w,
                                            ),
                                            Text(
                                              controller.doctor.address
                                                  .toString(),
                                              style: GoogleFonts.nunitoSans(
                                                  color: typingColor,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        // SizedBox(
                                        //   height: 12.h,
                                        // ),
                                        // Row(
                                        //   children: [
                                        //     ImageIcon(
                                        //       AssetImage(
                                        //           "assets/icons/telephone.png"),
                                        //       color: primaryColor,
                                        //       size: 30,
                                        //     ),
                                        //     SizedBox(
                                        //       width: 6.w,
                                        //     ),
                                        //     Text(
                                        //       controller.doctor["phoneNumber"],
                                        //       style: GoogleFonts.nunitoSans(
                                        //           color: typingColor,
                                        //           fontSize: 16.sp,
                                        //           fontWeight: FontWeight.w600),
                                        //     ),
                                        //   ],
                                        // ),
                                      ],
                                    ),
                                    controller.isConnected
                                        ? GestureDetector(
                                            onTap: () {
                                              // Get.to(ChatScreen(
                                              //     chatUser: chatUser));
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(12),
                                              height: 50.h,
                                              width: 50.w,
                                              decoration: const BoxDecoration(
                                                color: primaryColor,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const ImageIcon(
                                                AssetImage(
                                                  "assets/icons/chat.png",
                                                ),
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        : GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              padding: const EdgeInsets.all(12),
                                              height: 50.h,
                                              width: 50.w,
                                              decoration: const BoxDecoration(
                                                color: primaryColor,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const ImageIcon(
                                                AssetImage(
                                                  "assets/icons/add-user.png",
                                                ),
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                  ],
                                ),
                                SizedBox(
                                  height: 26.h,
                                ),
                                Text(
                                  "Description",
                                  style: GoogleFonts.nunitoSans(
                                    fontSize: 20.sp,
                                    color: typingColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                Text(
                                  controller.doctor.description.toString(),
                                  maxLines: 6,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.nunitoSans(
                                    fontSize: 18.sp,
                                    color: typingColor.withOpacity(0.75),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Visibility(
                                    visible: controller
                                            .doctor.buildingpictures!.isNotEmpty
                                        ? true
                                        : false,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 26.h,
                                        ),
                                        Text(
                                          controller.doctor.role == "Doctor"
                                              ? "Cabinet pictures"
                                              : "${controller.doctor.role} pictures",
                                          style: GoogleFonts.nunitoSans(
                                            fontSize: 20.sp,
                                            color: typingColor,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 12.h,
                                        ),
                                        if (controller.doctor.buildingpictures!
                                                .isNotEmpty &&
                                            controller
                                                    .doctor.buildingpictures !=
                                                null) ...[
                                          SizedBox(
                                            height: 180.h,
                                            child: ListView.builder(
                                              itemCount: controller.doctor
                                                  .buildingpictures!.length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                final picture = controller
                                                    .doctor
                                                    .buildingpictures![index];
                                                return Padding(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                          index == 0 ? 0 : 12),
                                                  child: Container(
                                                    width: 200.w,
                                                    decoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(12.r),
                                                      ),
                                                    ),
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    child: Image.network(
                                                      picture,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ]
                                      ],
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: defaultScreenPadding,
                      vertical: defaultScreenPadding,
                    ),
                    child: CustomAppBar(
                      title: "",
                      onBack: () {
                        //  navigate to the previous page
                        patientNavigationController.updateCurrentPage(
                            patientNavigationController.previousPage);
                        patientNavigationController.updateCurrentDoctorPage(0);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
