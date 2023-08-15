import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilink_app/models/reminder.dart';
import 'package:medilink_app/settings/shared_prefs.dart';
import 'package:medilink_app/utils/constants.dart';

class UpcomingPrescriptionCard extends StatelessWidget {
  const UpcomingPrescriptionCard({super.key, required this.medication});

  final Reminder medication;

  @override
  Widget build(BuildContext context) {
    Color color = getRandomColor();
    return Container(
      margin: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 20,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(22),
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(
              84,
              228,
              226,
              222,
            ),
            blurRadius: 6.0, // soften the shadow
            spreadRadius: 0.0, //extend the shadow
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 0,
          vertical: 20,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: color,
                        offset: const Offset(5, 5),
                        blurRadius: 40.0, // soften the shadow
                        spreadRadius: 0.0, //extend the shadow
                      )
                    ],
                  ),
                  child: ImageIcon(
                    const AssetImage(
                      "assets/icons/capsule-full.png",
                    ),
                    size: 50,
                    color: color,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      medication.name,
                      style: GoogleFonts.nunitoSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: typingColor,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    if (medication.instructions != null &&
                        medication.instructions!.isNotEmpty) ...[
                      SizedBox(
                        width: 140,
                        child: Text(
                          "${medication.instructions}",
                          maxLines: 3,
                          style: const TextStyle(
                            color: darkGreyColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const ImageIcon(
                          AssetImage(
                            "assets/icons/pill.png",
                          ),
                          color: Color.fromARGB(91, 37, 200, 237),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          "${medication.dosage}",
                          style: const TextStyle(
                            color: typingColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        const ImageIcon(
                          AssetImage(
                            "assets/icons/clock-full.png",
                          ),
                          color: Color.fromARGB(91, 37, 200, 237),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          '${medication.notificationTime.hour}:${medication.notificationTime.minute.toString().padLeft(2, '0')}',
                          style: const TextStyle(
                            color: typingColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  width: 12,
                ),
              ],
            ),
            medication.uuid != Pref().prefs!.getString(kuuid)
                ? const Text("Do u want to set a reminder in this device too")
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
