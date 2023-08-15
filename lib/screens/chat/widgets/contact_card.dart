import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:medilink_app/utils/constants.dart';


class ContactCard extends StatelessWidget {
  const ContactCard({
    super.key,
    required this.index,
    required this.doctor,
    required this.onTap,
  });
  final VoidCallback onTap;

  final int index;
  final Map<String, dynamic> doctor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.grey[50],
                  backgroundImage: AssetImage(doctor["image"]),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor["name"],
                      style: GoogleFonts.nunitoSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: typingColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Opacity(
                      opacity: 0.64,
                      child: Text(
                        doctor["speciality"],
                        style: const TextStyle(
                          fontSize: 16,
                          color: typingColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: Image.asset(
                "assets/icons/message.png",
                width: 33,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
