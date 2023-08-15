import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilink_app/components/custom_button.dart';
import 'package:medilink_app/screens/authentification/signup/components/signup_form.dart';
import 'package:medilink_app/utils/constants.dart';

import 'forgetpasswordemailcontroller.dart';

class ForgetpasswordMailscreen extends StatelessWidget {
  const ForgetpasswordMailscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: defaultScreenPadding,
            vertical: defaultScreenPadding,
          ),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Center(
                  child: Image.asset(
                kForgetPassImage,
                height: 250.h,
              )),
              const Text(
                "Forget Password",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 40.h),
              GetBuilder<ForgetPassEmail>(
                  init: ForgetPassEmail(),
                  builder: (controller) {
                    return Form(
                        key: controller.formKeySignIn,
                        child: Column(
                          children: [
                            buildEmailFormField(controller),
                            SizedBox(height: 10.h),
                            //FormError(errors: controller.errors),
                            Obx(() {
                              return CustomButton(
                                  buttonText: "kbutton1".tr,
                                  isLoading: controller.isLoading.value,
                                  onPress: () async {
                                    controller.onSubmit();
                                  });
                            }),
                          ],
                        ));
                  }),
            ],
          ),
        ),
      )),
    );
  }
}

TextFormField buildEmailFormField(ForgetPassEmail controller) {
  return TextFormField(
    keyboardType: TextInputType.emailAddress,
    onSaved: (newValue) => controller.emailController.text = newValue!,
    onChanged: controller.onChangedEmail,
    // validator: controller.validateEmail,
    controller: controller.emailController,
    decoration: buildInputDecoration(
        hintText: "kemailhint".tr,
        prefixIconImage: "mail_5.png",
        labelText: ''),
    style: GoogleFonts.nunitoSans(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: typingColor,
    ),
  );
}
