import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilink_app/utils/constants.dart';

class SectionDivider extends StatelessWidget {
  const SectionDivider({
    super.key,
    required this.sectionTitle,
    required this.onTap,
  });

  final String sectionTitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          sectionTitle,
          style: GoogleFonts.nunitoSans(
            color: typingColor,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            "See all",
            style: GoogleFonts.nunitoSans(
              color: darkGreyColor,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}
