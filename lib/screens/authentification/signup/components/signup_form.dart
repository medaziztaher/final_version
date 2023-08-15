import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilink_app/components/custom_button.dart';
import 'package:medilink_app/components/texte_field_label.dart';
import 'package:medilink_app/screens/authentification/signup/signup_controller.dart';
import 'package:medilink_app/utils/constants.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignupController>(
      init: SignupController(),
      builder: (controller) {
        return Form(
          key: controller.formKeySignUp,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: controller.role == 'Patient' ? true : false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextFieldLabel(label: "First Name"),
                    SizedBox(
                      height: 6.h,
                    ),
                    buildFirstNameFormField(controller),
                    SizedBox(
                      height: 18.h,
                    ),
                    const TextFieldLabel(label: "Last Name"),
                    SizedBox(
                      height: 6.h,
                    ),
                    buildLastNameFormField(controller),
                    SizedBox(
                      height: 18.h,
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: controller.role == 'HealthcareProvider' ? true : false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                        visible: controller.type == 'Doctor' ? true : false,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TextFieldLabel(label: "First Name "),
                              SizedBox(
                                height: 6.h,
                              ),
                              buildFirstNameFormField(controller),
                              SizedBox(
                                height: 18.h,
                              ),
                              const TextFieldLabel(label: "Last Name"),
                              SizedBox(
                                height: 6.h,
                              ),
                              buildLastNameFormField(controller),
                              SizedBox(
                                height: 18.h,
                              ),
                            ])),
                    Visibility(
                      visible: controller.type != 'Doctor' ? true : false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFieldLabel(label: "${controller.type} Name"),
                          SizedBox(
                            height: 6.h,
                          ),
                          buildNameFormField(controller),
                          SizedBox(
                            height: 18.h,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const TextFieldLabel(label: "Email "),
              SizedBox(
                height: 6.h,
              ),
              buildEmailFormField(controller),
              SizedBox(
                height: 18.h,
              ),
              const TextFieldLabel(label: "Password "),
              SizedBox(
                height: 6.h,
              ),
              buildPasswordFormField(controller),
              SizedBox(
                height: 18.h,
              ),
              const TextFieldLabel(label: "Confirm Password "),
              SizedBox(
                height: 6.h,
              ),
              buildConfirmPassword(controller),
              SizedBox(
                height: 26.h,
              ),
              Obx(() {
                return CustomButton(
                    buttonText: "kbutton1".tr,
                    isLoading: controller.isLoading.value,
                    onPress: () async {
                      controller.submitForm();
                    });
              }),
            ],
          ),
        );
      },
    );
  }
}

InputDecoration buildInputDecoration({
  required String hintText,
  required String prefixIconImage,
  Widget? suffixIcon,
  String? labelText,
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

TextFormField buildEmailFormField(SignupController controller) {
  return TextFormField(
    textDirection: TextDirection.ltr,
    keyboardType: TextInputType.emailAddress,
    onSaved: (newValue) => controller.emailController.text = newValue!,
    onChanged: (value) => controller.onChangedEmail(value),

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

TextFormField buildPasswordFormField(SignupController controller) {
  return TextFormField(
    obscureText: true,
    onSaved: (newValue) => controller.passwordController.text = newValue!,
    onChanged: (value) => controller.onChangedPassword(value),
    // validator: controller.validateEmail,
    controller: controller.passwordController,
    decoration: buildInputDecoration(
        hintText: "kpasswordhint".tr, prefixIconImage: "lock.png"),
    style: GoogleFonts.nunitoSans(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: typingColor,
    ),
  );
}

TextFormField buildConfirmPassword(SignupController controller) {
  return TextFormField(
    obscureText: true,
    onSaved: (newValue) => controller.confirmpassword,
    onChanged: (value) => controller.onChangedConfirmPassword(value),
    decoration: buildInputDecoration(
        hintText: "kconfirmpasswordhint".tr, prefixIconImage: "lock.png"),
    style: GoogleFonts.nunitoSans(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: typingColor,
    ),
  );
}

TextFormField buildNameFormField(SignupController controller) {
  return TextFormField(
    onSaved: (newValue) => controller.nameController.text = newValue!,
    onChanged: (value) => controller.onChangedname(value),
    // validator: controller.validateEmail,
    controller: controller.nameController,
    decoration: buildInputDecoration(
        hintText: "kname".tr, prefixIconImage: "person.png", labelText: ''),
    style: GoogleFonts.nunitoSans(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: typingColor,
    ),
  );
}

TextFormField buildFirstNameFormField(SignupController controller) {
  return TextFormField(
    onSaved: (newValue) => controller.firstnameController.text = newValue!,
    onChanged: (value) => controller.onChangedfirstname(value),
    // validator: controller.validateEmail,
    controller: controller.firstnameController,
    decoration: buildInputDecoration(
        hintText: "kfirstname".tr,
        prefixIconImage: "person.png",
        labelText: ''),
    style: GoogleFonts.nunitoSans(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: typingColor,
    ),
  );
}

TextFormField buildLastNameFormField(SignupController controller) {
  return TextFormField(
    onSaved: (newValue) => controller.lastnameController.text = newValue!,
    onChanged: (value) => controller.onChangedlastname(value),
    // validator: controller.validateEmail,
    controller: controller.lastnameController,
    decoration: buildInputDecoration(
        hintText: "klastname".tr, prefixIconImage: "person.png", labelText: ''),
    style: GoogleFonts.nunitoSans(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: typingColor,
    ),
  );
}

DropdownButtonFormField<String> buildTypeFormField(
    SignupController controller) {
  final List<String> typeValues = [
    'Doctor',
    'Center d\'imagerie Medicale',
    'Laboratoire',
  ];

  assert(typeValues.toSet().length == typeValues.length);

  String? defaultValue = controller.type;

  if (!typeValues.contains(defaultValue)) {
    defaultValue = null;
  }

  return DropdownButtonFormField<String>(
    value: defaultValue,
    onChanged: (value) => controller.onChangedType(value),
    // validator: (value) => controller.validateType(value),
    items: typeValues
        .map((type) => DropdownMenuItem(
              value: type,
              child: Text(type),
            ))
        .toList(),
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
