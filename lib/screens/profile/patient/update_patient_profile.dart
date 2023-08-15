import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medilink_app/components/custom_button.dart';
import 'package:medilink_app/screens/profile/components/profile_pic.dart';
import 'package:medilink_app/screens/profile/profile_controller.dart';
import 'package:medilink_app/utils/constants.dart';

class UpdatePatientProfile extends StatelessWidget {
  const UpdatePatientProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 5.h),
                Text("kcomplet".tr, style: headingStyle),
                SizedBox(height: 2.h),
                const ProfileImage(),
                SizedBox(height: 3.h),
                GetBuilder<EditProfileController>(
                    // init: EditProfileController(user: user),
                    builder: (controller) {
                  return Form(
                    key: controller.formKeyEditProfile,
                    child: Column(
                      children: [
                        buildGenderFormField(controller),
                        SizedBox(height: 12.h),
                        buildEmailFormField(controller),
                        SizedBox(height: 12.h),
                        buildFirstNameFormField(controller),
                        SizedBox(height: 12.h),
                        buildLastNameFormField(controller),
                        SizedBox(height: 12.h),
                        buildPasswordFormField(controller),
                        SizedBox(height: 12.h),
                        if (controller.passwordController.text.isNotEmpty) ...[
                          buildConfirmPassword(controller),
                          SizedBox(height: 12.h),
                        ],
                        buildAddressFormField(controller),
                        SizedBox(height: 12.h),
                        buildPhoneNumberFormField(controller),
                        SizedBox(height: 12.h),
                        buildbirthdateField(context, controller),
                        SizedBox(height: 12.h),
                        buildTypeFormField(controller),
                        SizedBox(height: 7.h),
                        Visibility(
                            visible: controller.etatcivil != 'Single',
                            child: buildnemberdenfant(controller)),
                        SizedBox(height: 7.h),
                        //FormError(errors: controller.errors),
                        SizedBox(height: 20.h),
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
        suffixIcon: const Icon(Icons.phone_android),
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
        suffixIcon: const Icon(Icons.location_pin),
      ),
    );
  }

  DropdownButtonFormField<String> buildTypeFormField(
      EditProfileController controller) {
    final List<String> typeValues = [
      'Single',
      'Married',
      'Divorced',
      'Widowed',
    ];

    assert(typeValues.toSet().length == typeValues.length);

    String? defaultValue = typeValues.first;

    if (!typeValues.contains(defaultValue)) {
      defaultValue = null;
    }

    return DropdownButtonFormField<String>(
      value: defaultValue,
      onChanged: (value) => controller.onChangedetatcivil(value),
      items: typeValues
          .map((type) => DropdownMenuItem(
                value: type,
                child: Text(type),
              ))
          .toList(),
      decoration: const InputDecoration(
        labelText: "Civil State",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildnemberdenfant(EditProfileController controller) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) =>
          controller.nembredenfantController.text = newValue!,
      controller: controller.nembredenfantController,
      decoration: const InputDecoration(
        labelText: "Nembre d'enfant",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildbirthdateField(
      BuildContext context, EditProfileController controller) {
    return TextFormField(
      controller: controller.dateofbirthController,
      readOnly: true,
      onTap: () async {
        final DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );

        if (selectedDate != null) {
          final DateFormat formatter = DateFormat('yyyy-MM-dd');
          final String formattedDate = formatter.format(selectedDate);
          controller.dateofbirthController.text = formattedDate;
        }
      },
      decoration: InputDecoration(
        labelText: "kbirthdate".tr,
        hintText: "kbirthdatehint".tr,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the date';
        }
        return null;
      },
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
      suffixIcon: const Icon(Icons.email),
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
      suffixIcon: const Icon(Icons.lock),
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
      suffixIcon: const Icon(Icons.person),
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
      suffixIcon: const Icon(Icons.person),
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
      suffixIcon: const Icon(Icons.lock),
    ),
  );
}
