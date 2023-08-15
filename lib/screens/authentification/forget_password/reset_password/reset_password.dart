import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medilink_app/components/custom_button.dart';
import 'package:medilink_app/screens/authentification/forget_password/reset_password/reset_pass_controller.dart';
import 'package:medilink_app/utils/constants.dart';

class ResetPassScreen extends StatelessWidget {
  const ResetPassScreen({super.key, required this.email});
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
                SizedBox(height: 5.h),
                Text(
                  "Enter new password".tr,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 1.h),
                Text("tOtpMessage".tr),
                SizedBox(height: 6.h),
                GetBuilder<ResetPassController>(
                    init: ResetPassController(email: email),
                    builder: (controller) {
                      return Form(
                          key: controller.formKeyResetPass,
                          child: Column(children: [
                            buildPasswordFormField(controller),
                            SizedBox(height: 6.h),
                            buildConfirmPassword(controller),
                            SizedBox(height: 6.h),
                            //FormError(errors: controller.errors),
                            SizedBox(height: 7.h),
                            Obx(() {
                              return CustomButton(
                                  buttonText: "kbutton1".tr,
                                  isLoading: controller.isLoading.value,
                                  onPress: () async {
                                    controller.submitForm();
                                  });
                            }),
                          ]));
                    }),
              ],
            ),
          ),
        ),
      )),
    );
  }
}

TextFormField buildPasswordFormField(ResetPassController controller) {
  return TextFormField(
    obscureText: true,
    onSaved: (newValue) => controller.passwordController.text = newValue!,
    onChanged: (value) => controller.onChangedPassword(value),
    validator: (value) => controller.validatePassword(value),
    controller: controller.passwordController,
    decoration: InputDecoration(
      labelText: "kpassword".tr,
      hintText: "kpasswordhint".tr,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      suffixIcon: Icon(Icons.lock),
    ),
  );
}

TextFormField buildConfirmPassword(ResetPassController controller) {
  return TextFormField(
    obscureText: true,
    onSaved: (newValue) => controller.confirmpassword,
    onChanged: (value) => controller.onChangedConfirmPassword(value),
    validator: (value) => controller.validateconfirmPassword(value),
    decoration: InputDecoration(
      labelText: "kconfirmpassword".tr,
      hintText: "kconfirmPassNullError".tr,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      suffixIcon: Icon(Icons.lock),
    ),
  );
}
