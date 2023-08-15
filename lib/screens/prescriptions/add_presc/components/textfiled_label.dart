import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilink_app/utils/constants.dart';


class TextFieldLabel extends StatelessWidget {
  const TextFieldLabel({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.nunitoSans(
        fontSize: 18,
        color: typingColor,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
