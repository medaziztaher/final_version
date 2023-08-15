import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilink_app/components/custom_button.dart';
import 'package:medilink_app/screens/emergency_contact/add_emergency_conatct/add_emergency_contact_controller.dart';
import 'package:medilink_app/screens/emergency_contact/add_emergency_conatct/components/add_emergency_contact_form.dart';
import 'package:medilink_app/utils/constants.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    EmergencyContactController controller =
        Get.put(EmergencyContactController());

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: defaultScreenPadding.w,
          vertical: defaultScreenPadding.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const ImageIcon(
                    AssetImage("assets/icons/back.png"),
                    color: typingColor,
                    size: 26,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text("Add Emergency contact",
                        style: GoogleFonts.nunitoSans(
                          color: typingColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 22.sp,
                        )),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 36.h,
            ),
            const EmergencyContactForm(),
            SizedBox(
              height: 36.h,
            ),
            // FormError(errors: controller.errors),
            CustomButton(
              buttonText: "kbutton1".tr,
              isLoading: controller.isLoading.value,
              onPress: () async {
                controller.next();
              },
            ),
          ],
        ),
      ),
    );
  }
}
