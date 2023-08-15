import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/utils/constants.dart';

class HeadingDoctorCard extends StatelessWidget {
  const HeadingDoctorCard({
    super.key,
    required this.doctor,
  });

  final User doctor;

  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.hardEdge,
        width: 162,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(22),
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 120,
              width: 162,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(96, 171, 182, 234),
                    blurRadius: 30.0, // soften the shadow
                    spreadRadius: 0.0, //extend the shadow
                  )
                ],
                color: lightBlueColor,
              ),
              child: /* doctor.picture != null
                  ? CachedNetworkImage(imageUrl: doctor.picture!)
                  :*/
                  Image.asset(kProfile),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    doctor.name,
                    style: GoogleFonts.nunitoSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: typingColor,
                    ),
                  ),
                  Text(
                    doctor.speciality ?? "",
                    style: GoogleFonts.nunitoSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: darkGreyColor,
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
