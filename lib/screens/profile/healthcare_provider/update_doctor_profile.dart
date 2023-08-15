import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medilink_app/components/custom_button.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/screens/profile/components/profile_pic.dart';
import 'package:medilink_app/screens/profile/profile_controller.dart';
import 'package:medilink_app/utils/constants.dart';

class DoctorProfil extends StatelessWidget {
  const DoctorProfil({super.key, required this.user});
  final User user;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text("kcomplet".tr, style: headingStyle),
            ProfileImage(),
            GetBuilder<EditProfileController>(
                init: EditProfileController(user: user),
                builder: (controller) {
                  return Form(
                    key: controller.formKeyEditProfile,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 12.h,
                        ),
                        buildGenderFormField(controller),
                        SizedBox(
                          height: 12.h,
                        ),
                        buildEmailFormField(controller),
                        SizedBox(
                          height: 12.h,
                        ),
                        buildFirstNameFormField(controller),
                        SizedBox(
                          height: 12.h,
                        ),
                        buildLastNameFormField(controller),
                        SizedBox(
                          height: 12.h,
                        ),
                        buildPasswordFormField(controller),
                        SizedBox(
                          height: 12.h,
                        ),
                        if (controller.passwordController.text.isNotEmpty) ...[
                          buildConfirmPassword(controller),
                        ],
                        SizedBox(
                          height: 12.h,
                        ),
                        buildAddressFormField(controller),
                        SizedBox(
                          height: 12.h,
                        ),
                        buildPhoneNumberFormField(controller),
                        SizedBox(
                          height: 12.h,
                        ),
                        builddescriptionFormField(controller),
                        // FormError(errors: controller.errors),
                        Obx(() {
                          return CustomButton(
                              buttonText: "kbutton1".tr,
                              isLoading: controller.isLoading.value,
                              onPress: () async {
                                controller.updateProfil();
                              });
                        }),
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField(EditProfileController controller) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => controller.phoneNumberController.text = newValue!,
      onChanged: (value) => controller.onChangedphonenumber(value),
      validator: (value) => controller.validatephoneNumber(value),
      controller: controller.phoneNumberController,
      decoration: InputDecoration(
        labelText: "kphonenumber".tr,
        hintText: "kphonenumberhint".tr,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.phone_android),
      ),
    );
  }

  Row buildGenderFormField(EditProfileController controller) {
    return Row(
      children: [
        Expanded(
          child: RadioListTile<String>(
            title: Text('kmale'.tr),
            value: 'Male',
            groupValue: controller.gender,
            onChanged: (value) => controller.onChangedGender(value),
          ),
        ),
        Expanded(
          child: RadioListTile<String>(
            title: Text('kfemale'.tr),
            value: 'Female',
            groupValue: controller.gender,
            onChanged: (value) => controller.onChangedGender(value),
          ),
        ),
      ],
    );
  }

  TextFormField buildAddressFormField(EditProfileController controller) {
    return TextFormField(
      onSaved: (newValue) => controller.adressController.text = newValue!,
      controller: controller.adressController,
      decoration: InputDecoration(
        labelText: "kaddress".tr,
        hintText: "kaddresshint".tr,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.location_pin),
      ),
    );
  }

  TextFormField builddescriptionFormField(EditProfileController controller) {
    return TextFormField(
      onSaved: (newValue) => controller.descriptionController.text = newValue!,
      onChanged: (value) => controller.onChangeddescription(value),
      validator: (value) => controller.validatedescription(value),
      controller: controller.descriptionController,
      maxLines: 3,
      decoration: InputDecoration(
        labelText: "kAbout".tr,
        hintText: "kAbouthint".tr,
        helperText: "khint".tr,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}

TextFormField buildEmailFormField(EditProfileController controller) {
  return TextFormField(
    keyboardType: TextInputType.emailAddress,
    onSaved: (newValue) => controller.emailController.text = newValue!,
    onChanged: (value) => controller.onChangedEmail(value),
    validator: (value) => controller.validateEmail(value),
    controller: controller.emailController,
    decoration: InputDecoration(
      labelText: "kemail".tr,
      hintText: "kemailhint".tr,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      suffixIcon: Icon(Icons.email),
    ),
  );
}

TextFormField buildPasswordFormField(EditProfileController controller) {
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

TextFormField buildFirstNameFormField(EditProfileController controller) {
  return TextFormField(
    onSaved: (newValue) => controller.firstnameController.text = newValue!,
    onChanged: (value) => controller.onChangedfirstname(value),
    validator: (value) => controller.validateFirstName(value),
    controller: controller.firstnameController,
    decoration: InputDecoration(
      labelText: "kfirstname".tr,
      hintText: "kfirstnamehint".tr,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      suffixIcon: Icon(Icons.person),
    ),
  );
}

TextFormField buildLastNameFormField(EditProfileController controller) {
  return TextFormField(
    onSaved: (newValue) => controller.lastnameController.text = newValue!,
    onChanged: (value) => controller.onChangedlastname(value),
    validator: (value) => controller.validateLastName(value),
    controller: controller.lastnameController,
    decoration: InputDecoration(
      labelText: "klastname".tr,
      hintText: "klastnamehint".tr,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      suffixIcon: Icon(Icons.person),
    ),
  );
}

TextFormField buildConfirmPassword(EditProfileController controller) {
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
