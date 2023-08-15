import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilink_app/models/prescription.dart';
import 'package:medilink_app/utils/constants.dart';


Row greeting(String timeOfDay) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          ImageIcon(
            AssetImage(
                "assets/icons/${timeOfDay == "Morning" ? "sun.png" : "moon.png"}"),
            color: primaryColor.withOpacity(0.5),
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            timeOfDay,
            style: GoogleFonts.nunitoSans(
              color: typingColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      Text(
        "${upcomingPills.length} Items",
        style: GoogleFonts.nunitoSans(
          color: typingColor.withOpacity(0.65),
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      )
    ],
  );
}
