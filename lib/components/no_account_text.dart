import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilink_app/screens/authentification/signup/components/register_type_page.dart';
import 'package:medilink_app/utils/constants.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "knoacount".tr,
          style: GoogleFonts.nunitoSans(
            color: typingColor.withOpacity(0.75),
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        GestureDetector(
          onTap: () {
            Get.to(const RegisterTypedPage(), transition: Transition.rightToLeft);
          },
          child: Text(
            "ksingup".tr,
            style: GoogleFonts.nunitoSans(
              color: primaryColor,
              fontWeight: FontWeight.w700,
              fontSize: 16.sp,
            ),
          ),
        )
      ],
    );
  }
}
