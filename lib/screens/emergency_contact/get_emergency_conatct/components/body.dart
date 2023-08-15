import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilink_app/models/emergency_contact.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/screens/emergency_contact/get_emergency_conatct/get_emrgency_conatcts_controller.dart';
import 'package:medilink_app/utils/constants.dart';

class Body extends StatelessWidget {
  const Body({super.key, required this.user, this.userId});
  final User user;
  final String? userId;

  @override
  Widget build(BuildContext context) {
    final userDiseaseController =
        Get.put(UserEmergencyContactController(userId: user.id));
    userDiseaseController.getUserEmergencyContacts();

    return Obx(() {
      if (userDiseaseController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (userDiseaseController.emergencyContacts.isNotEmpty) {
        final emergencyContacts = userDiseaseController.emergencyContacts;
        return ListView.builder(
          itemCount: emergencyContacts.length,
          itemBuilder: (context, index) {
            final emergencyContact = emergencyContacts[index];
            return Padding(
              padding: EdgeInsets.all(10.w),
              child: emergencyCard(emergencyContact),
            );
          },
        );
      } else {
        return Center(
            child: userId == user.id
                ? const Text('You don\'t have any emergencyContacts')
                : Text('this ${user.name} don\'t have any emergencyContacts'));
      }
    });
  }
}

Row emergencyCard(EmergencyContact user) {
  return Row(
    children: [
      CircleAvatar(
        maxRadius: 30,
        backgroundImage: user.picture != null
            ? CachedNetworkImageProvider(user.picture!)
            : const AssetImage(kProfile) as ImageProvider,
      ),
      const SizedBox(
        width: 12,
      ),
      Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [
          Text(
           "Name : ${user.name}" ,
            style: GoogleFonts.nunitoSans(
              color: typingColor,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            "Relation : ${user.relationship}",
            style: GoogleFonts.nunitoSans(
              color: typingColor,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            "Phone Number : ${user.phoneNumber}",
            style: GoogleFonts.nunitoSans(
              color: typingColor,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      )
    ],
  );
}
