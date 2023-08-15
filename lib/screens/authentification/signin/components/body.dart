import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilink_app/components/no_account_text.dart';
import 'package:medilink_app/screens/authentification/signin/components/signin_form.dart';
import 'package:medilink_app/utils/constants.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: defaultScreenPadding.w,
          vertical: defaultScreenPadding.w,
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              const Spacer(
                flex: 2,
              ),
              Text("kwelcome".tr,
                  style: GoogleFonts.nunitoSans(
                    color: typingColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 36.sp,
                  )),
              SizedBox(
                height: 18.h,
              ),
              Text(
                "kcontinue".tr,
                style: GoogleFonts.nunitoSans(
                  color: typingColor.withOpacity(0.75),
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(
                height: 36.h,
              ),
              const SignIn(),
              SizedBox(
                height: 36.h,
              ),
              const NoAccountText(),
              const Spacer(
                flex: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
