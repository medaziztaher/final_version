import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/utils/constants.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    super.key,
    required this.index,
    required this.doctor,
  });
  final int index;
  final User doctor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: index == 0 ? 0 : defaultListViewItemsPadding,
        bottom: index == doctors.length - 1 ? defaultListViewItemsPadding : 0,
      ),
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(12.r),
            ),
          ),
          height: 110.h,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: lightBlueColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.r),
                    ),
                  ),
                  height: 110.h,
                  width: 90.w,
                  child: doctor.picture != null
                      ? Image.asset(
                          doctor.picture!,
                        )
                      : Image.asset(kProfile),
                ),
                SizedBox(
                  width: 16.w,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                doctor.type == "Doctor"
                                    ? Text(
                                        "${doctor.firstname} ${doctor.lastname}",
                                        style: GoogleFonts.nunitoSans(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w700,
                                            color: typingColor),
                                      )
                                    : Text(doctor.name),
                                SizedBox(
                                  height: 2.h,
                                ),
                                doctor.speciality != null &&
                                        doctor.type == 'Doctor'
                                    ? Text(
                                        doctor.speciality!,
                                        style: GoogleFonts.nunitoSans(
                                          fontSize: 16.sp,
                                          color: darkGreyColor,
                                        ),
                                      )
                                    : Text("${doctor.type}"),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(87, 133, 147, 235),
                                    blurRadius: 50.0,
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: const ImageIcon(
                                AssetImage("assets/icons/place.png"),
                                size: 20,
                                color: Color.fromARGB(134, 37, 200, 237),
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Flexible(
                              child: doctor.address != null
                                  ? Text(
                                      doctor.address!,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.nunitoSans(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                        color: const Color.fromARGB(
                                            232, 37, 200, 237),
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
