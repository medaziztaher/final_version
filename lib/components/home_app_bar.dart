import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilink_app/screens/home/home_controller.dart';
import 'package:medilink_app/screens/notification/notification_screen.dart';
import 'package:medilink_app/utils/constants.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    HomeData homeController = Get.put(HomeData());

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              maxRadius: 28,
              backgroundImage: homeController.user.picture != null
                  ? CachedNetworkImageProvider(homeController.user.picture!)
                  : AssetImage(kProfile) as ImageProvider,
            ),
            const SizedBox(
              width: 14,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      "Hi, ",
                      style: TextStyle(
                        fontSize: 20,
                        color: typingColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    homeController.user.role == 'HealthcareProvider' &&
                            homeController.user.type == 'Doctor'
                        ? Text(
                            "Dr. ${homeController.user.firstname}",
                            style: GoogleFonts.nunitoSans(
                              fontSize: 20,
                              color: typingColor,
                              fontWeight: FontWeight.w800,
                            ),
                          )
                        : homeController.user.role == 'HealthcareProvider'
                            ? Text(homeController.user.name,
                                style: GoogleFonts.nunitoSans(
                                  fontSize: 20,
                                  color: typingColor,
                                  fontWeight: FontWeight.w800,
                                ))
                            : Text(
                                "${homeController.user.firstname}",
                                style: GoogleFonts.nunitoSans(
                                  fontSize: 20,
                                  color: typingColor,
                                  fontWeight: FontWeight.w800,
                                ),
                              )
                  ],
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  homeController.user.role == "Patient"
                      ? "How is your health?"
                      : "Nice to see you!",
                  style: GoogleFonts.nunitoSans(
                    color: darkGreyColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            )
          ],
        ),
        GestureDetector(
          onTap: () {
            Get.to(NotificationScreen());
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
