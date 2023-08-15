import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilink_app/utils/constants.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(96, 171, 182, 234),
              blurRadius: 6.0, // soften the shadow
              spreadRadius: 0.0, //extend the shadow
            )
          ],
        ),
        child: TextButton(
          style: TextButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            backgroundColor: Colors.white,
          ),
          onPressed: press,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 4,
              vertical: 12,
            ),
            child: Row(
              children: [
                Image.asset(
                  icon,
                  width: 44,
                ),
                const SizedBox(width: 20),
                Expanded(
                    child: Text(
                  text,
                  style: GoogleFonts.nunitoSans(
                    color: typingColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                )),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: typingColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
