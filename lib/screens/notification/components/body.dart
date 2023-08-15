import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:medilink_app/components/custom_app_bar.dart';
import 'package:medilink_app/models/notification.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/screens/analyse/get_analyse/get_analyse_screen.dart';
import 'package:medilink_app/screens/chat/screens/chat_screen.dart';
import 'package:medilink_app/screens/notification/notification_controller.dart';
import 'package:medilink_app/screens/prescriptions/get_presc/get_presc_screen.dart';
import 'package:medilink_app/screens/radiographie/get_radiographie/get_radiographie_screen.dart';
import 'package:medilink_app/screens/surgery/get_surgery/get_surgerie_screen.dart';
import 'package:medilink_app/screens/user/user_screen.dart';
import 'package:medilink_app/utils/constants.dart';



class Body extends StatelessWidget {
  const Body({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    final usernotificationController =
        Get.put(NotificationsController(user: user));
    usernotificationController.getUserNotifications();

    return SafeArea(
      child: Column(
        children: [
          const CustomAppBar(title: "Notifications", withoutNotifIcon: true),
          Expanded(
            child: Obx(() {
              if (usernotificationController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                );
              } else if (usernotificationController.notifications.isNotEmpty) {
                final notifications = usernotificationController.notifications;
                return ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final notification = notifications[index];
                    return GestureDetector(
                        onTap: () {
                          if (notification.notificationType == 'New message') {
                            Get.to(() =>
                                ChatScreen(convId: notification.payload!));
                          } else if (notification.notificationType ==
                              'New follow request') {
                            Get.to(() =>
                                UserScreen(userId: notification.payload!));
                          } else if (notification.notificationType ==
                              'Follow Request Approved') {
                            Get.to(() =>
                                UserScreen(userId: notification.payload!));
                          } else if (notification.notificationType ==
                              'Updated Laboratory Result') {
                            Get.to(() => GetAnalyseScreen(
                                analyseId: notification.payload!));
                          } else if (notification.notificationType ==
                              'New prescription Added') {
                            Get.to(() =>
                                GetPrescScreen(prescId: notification.payload!));
                          } else if (notification.notificationType ==
                              'New Radiographie Added') {
                            Get.to(() =>
                                GetRadioScreen(radioId: notification.payload!));
                          } else if (notification.notificationType ==
                              'New Surgerie added') {
                            Get.to(() => GetSurgerieScreen(
                                surgerieId: notification.payload!));
                          } else if (notification.notificationType ==
                              'New Laboratory Result added') {
                            Get.to(() => GetAnalyseScreen(
                                  analyseId: notification.payload!,
                                ));
                          } else if (notification.notificationType ==
                              'Updated Prescription') {
                            Get.to(() =>
                                GetPrescScreen(prescId: notification.payload!));
                          } else if (notification.notificationType ==
                              'Radiographie updated') {
                            Get.to(() =>
                                GetRadioScreen(radioId: notification.payload!));
                          } else if (notification.notificationType ==
                              'Surgery updated') {
                            Get.to(() => GetSurgerieScreen(
                                surgerieId: notification.payload!));
                          }
                        },
                        child: notificationCard(notification));
                  },
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/icons/bell.png",
                      width: 200,
                      color: typingColor.withOpacity(0.30),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Oops, no notification yet!",
                      style: GoogleFonts.nunitoSans(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: typingColor.withOpacity(0.65),
                      ),
                    ),
                  ],
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}

Container notificationCard(Notifications notification) {
  return Container(
    color: notification.isRead! ? Colors.white : Colors.blue,
    child: Row(
      children: [
        CircleAvatar(
          maxRadius: 30,
          backgroundImage: notification.senderPic != null
              ? CachedNetworkImageProvider(notification.senderPic!)
              : const AssetImage(kProfile) as ImageProvider,
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  notification.notificationType!,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  notification.content!,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMd().add_jm().format(notification.createdDate!),
                  style: GoogleFonts.nunitoSans(
                    color: typingColor.withOpacity(0.75),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    ),
  );
}
