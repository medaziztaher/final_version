import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilink_app/components/custom_button.dart';
import 'package:medilink_app/components/texte_field_label.dart';
import 'package:medilink_app/screens/authentification/forget_password/email/forgetpasswordemail.dart';
import 'package:medilink_app/screens/authentification/signin/signin_controller.dart';
import 'package:medilink_app/utils/constants.dart';
class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInController>(
      init: SignInController(),
      builder: (controller) {
        return Form(
          key: controller.formKeySignIn,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldLabel(label: "kemail".tr),
              SizedBox(
                height: 6.h,
              ),
              Container(
                  decoration: const BoxDecoration(),
                  child: buildEmailFormField(controller)),
              SizedBox(
                height: 18.h,
              ),
              TextFieldLabel(label: "kpassword".tr),
              SizedBox(
                height: 6.h,
              ),
              buildPasswordFormField(controller),
              SizedBox(
                height: 6.h,
              ),
              buildForgetPasswordText(context),
              SizedBox(
                height: 18.h,
              ),
              Obx(() {
                return CustomButton(
                  buttonText: "kbutton1".tr,
                  isLoading: controller.isLoading.value,
                  onPress: () async {
                    controller.submitForm();
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }

  TextFormField buildEmailFormField(SignInController controller) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => controller.emailController.text = newValue!,
      onChanged: controller.onChangedEmail,
      // validator: controller.validateEmail,
      controller: controller.emailController,
      decoration: buildInputDecoration(
          hintText: "kemailhint".tr, prefixIconImage: "mail_5.png"),
      style: GoogleFonts.nunitoSans(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: typingColor,
      ),
    );
  }

  TextFormField buildPasswordFormField(SignInController controller) {
    bool isPasswordVisible = !controller.passToggle.value;

    return TextFormField(
      obscureText: isPasswordVisible,
      onSaved: (newValue) => controller.passwordController.text = newValue!,
      onChanged: controller.onChangedPassword,
      // validator: controller.validatePassword,
      controller: controller.passwordController,
      decoration: buildInputDecoration(
        hintText: "kpasswordhint".tr,
        prefixIconImage: "lock.png",
        suffixIcon: buildPasswordVisibilityToggleIcon(controller),
      ),
      style: GoogleFonts.nunitoSans(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: typingColor,
      ),
    );
  }

  Widget buildForgetPasswordText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            const ForgetpasswordMailscreen();
          },
          child: Text(
            "kforgetpassword".tr,
            style: GoogleFonts.nunitoSans(
              color: primaryColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  InputDecoration buildInputDecoration({
    required String hintText,
    required String prefixIconImage,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide.none,
      ),
      hintStyle: GoogleFonts.nunitoSans(
        fontWeight: FontWeight.w600,
        fontSize: 16.sp,
        color: typingColor.withOpacity(0.75),
      ),
      prefixIcon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 10.w),
          ImageIcon(
            AssetImage("assets/icons/$prefixIconImage"),
            size: 30,
            color: typingColor.withOpacity(0.75),
          ),
        ],
      ),
      suffixIcon: suffixIcon, // Set the suffixIcon parameter
    );
  }

  IconButton buildPasswordVisibilityToggleIcon(SignInController controller) {
    bool isPasswordVisible = !controller.passToggle.value;

    return IconButton(
      icon: Icon(
        isPasswordVisible ? Icons.visibility_off : Icons.visibility,
        color: typingColor.withOpacity(0.75),
      ),
      onPressed: controller.togglePasswordVisibility,
    );
  }
}