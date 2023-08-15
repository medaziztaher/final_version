import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medilink_app/screens/authentification/forget_password/otp/otp_controller.dart';
import 'package:medilink_app/utils/constants.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: defaultScreenPadding,
            vertical: defaultScreenPadding,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 6.h),
                Text(
                  "kOtpTitle".tr,
                  style: const TextStyle(fontSize: 25, color: Colors.black),
                ),
                Text(
                  "kOtpsubTitle".tr,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 3.h),
                Text("tOtpMessage".tr),
                buildTimer(),
                SizedBox(height: 6.h),
                GetBuilder<OTPController>(
                    init: OTPController(email: email),
                    builder: (controller) {
                      return Form(
                        key: controller.formKeyOTP,
                        child: Column(
                          children: [
                            TextField(
                              controller: controller.otpController,
                              keyboardType: TextInputType.text,
                              maxLength: 6,
                              onChanged: (String code) {
                                if (code.length == 6) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("Verification Code"),
                                        content: Text('Code entered is $code'),
                                        actions: [
                                          TextButton(
                                            child: const Text('Submit'),
                                            onPressed: () {
                                              controller.submit();
                                            },
                                          ),
                                          TextButton(
                                            child: const Text('Cancel'),
                                            onPressed: () {
                                              Get.back();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              decoration: const InputDecoration(
                                counterText: '',
                                hintText: 'Enter OTP',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF512DA8),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF512DA8),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 6.h),
                            // FormError(errors: controller.errors),
                            SizedBox(height: 6.h),
                            Obx(() {
                              if (controller.isLoading.value == false) {
                                return GestureDetector(
                                  onTap: () {
                                    controller.resendOTP();
                                  },
                                  child: const Text(
                                    "Resend OTP Code",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline),
                                  ),
                                );
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            }),
                          ],
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      )),
    );
  }
}

Row buildTimer() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text("This code will expired in "),
      TweenAnimationBuilder(
        tween: Tween(begin: 60.0, end: 0.0),
        duration: const Duration(seconds: 60),
        builder: (_, dynamic value, child) => Text(
          "00:${value.toInt()}",
          style: const TextStyle(color: primaryColor),
        ),
      ),
    ],
  );
}
