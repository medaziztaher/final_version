import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilink_app/utils/constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    // this.controller,
    required this.title,
    this.withoutNotifIcon = false,
    this.onBack,
  });

  final String title;
  final bool withoutNotifIcon;
  final VoidCallback? onBack;

  // final Controller controller;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                onBack != null ? onBack!() : Get.back();
              },
              child: const ImageIcon(
                AssetImage("assets/icons/back.png"),
                color: typingColor,
                size: 26,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              title,
              style: GoogleFonts.nunitoSans(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: typingColor,
              ),
            ),
          ],
        ),
        withoutNotifIcon
            ? Container()
            : InkWell(
                onTap: () {
                  //Get.to(NotificationScreen());
                },
                child: Container(
                  width: 42,
                  height: 42,
                  padding: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(84, 228, 226, 226),
                        blurRadius: 15.0, // soften the shadow
                        spreadRadius: 3.0, //extend the shadow
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(14),
                    ),
                  ),
                  child: const ImageIcon(
                    AssetImage("assets/icons/bell-ring.png"),
                    color: typingColor,
                  ),
                ),
              )
      ],
    );
  }
}
