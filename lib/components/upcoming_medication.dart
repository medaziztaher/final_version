import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilink_app/models/reminder.dart';
import 'package:medilink_app/settings/shared_prefs.dart';
import 'package:medilink_app/utils/constants.dart';

class UpcomingMedicationCard extends StatefulWidget {
  const UpcomingMedicationCard({
    super.key,
    required this.item,
  });
  final Reminder item;

  @override
  State<UpcomingMedicationCard> createState() => _UpcomingMedicationCardState();
}

class _UpcomingMedicationCardState extends State<UpcomingMedicationCard> {
  @override
  Widget build(BuildContext context) {
    Color color = getRandomColor();
    return Container(
      height: 150,
      width: 180,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(22),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 16, left: 12, right: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Flexible(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.item.name,
                        style: GoogleFonts.nunitoSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: typingColor,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      if (widget.item.instructions != null &&
                          widget.item.instructions!.isNotEmpty) ...[
                        Text(
                          widget.item.instructions!,
                          maxLines: 2,
                          style: const TextStyle(
                            color: darkGreyColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
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
                    ],
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                      '${widget.item.notificationTime.hour}:${widget.item.notificationTime.minute.toString().padLeft(2, '0')}',
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
            widget.item.uuid != Pref().prefs!.getString(kuuid)
                ? const Text("Do u want to set a reminder in this device too")
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
