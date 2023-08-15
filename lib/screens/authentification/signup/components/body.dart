import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilink_app/screens/authentification/signup/components/signup_form.dart';
import 'package:medilink_app/utils/constants.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultScreenPadding,
          vertical: defaultScreenPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
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
            ]),
            SizedBox(
              height: 36.h,
            ),
            Text("kregister".tr,
                style: GoogleFonts.nunitoSans(
                  fontSize: 28,
                  color: typingColor,
                  fontWeight: FontWeight.w700,
                )),
            SizedBox(
              height: 18.h,
            ),
            Text(
              "kcompletewith".tr,
              style: GoogleFonts.nunitoSans(
                color: typingColor.withOpacity(0.75),
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(
              height: 36.h,
            ),
            const SignUp(),
            SizedBox(
              height: 36.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'kconditions'.tr,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunitoSans(
                    fontSize: 14.sp,
                    color: typingColor.withOpacity(0.75),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
