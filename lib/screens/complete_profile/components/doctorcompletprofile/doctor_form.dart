import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilink_app/components/custom_button.dart';
import 'package:medilink_app/models/specialite.dart';
import 'package:medilink_app/screens/authentification/signup/components/signup_form.dart';
import 'package:medilink_app/screens/complete_profile/complete_profile_controller.dart';
import 'package:medilink_app/screens/complete_profile/components/profile_img.dart';
import 'package:medilink_app/utils/constants.dart';

class DoctorForm extends StatelessWidget {
  const DoctorForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: defaultScreenPadding.w,
          vertical: defaultScreenPadding.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
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
                Expanded(
                  child: Center(
                    child: Text("kcomplet".tr,
                        style: GoogleFonts.nunitoSans(
                          color: typingColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 22.sp,
                        )),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 36.h,
            ),
            const ProfilePic(),
            SizedBox(
              height: 26.h,
            ),
            GetBuilder<CompleteProfileController>(
                init: CompleteProfileController(),
                builder: (controller) {
                  return Form(
                    key: controller.formKeyCompleteProfile,
                    child: Column(
                      children: [
                        buildGenderFormField(controller),
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
                        buildspecializationFormField(controller),
                        SizedBox(
                          height: 12.h,
                        ),
                        buildVerificationFormField(controller),
                        SizedBox(
                          height: 12.h,
                        ),
                        builddescriptionFormField(controller),
                        SizedBox(
                          height: 26.h,
                        ),
                        CustomButton(
                          buttonText: "kbutton1".tr,
                          isLoading: controller.isLoading.value,
                          onPress: () async {
                            controller.completeProfile();
                          },
                        )
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField(
      CompleteProfileController controller) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => controller.phoneNumberController.text = newValue!,
      onChanged: (value) => controller.onChangedphonenumber(value),
      validator: (value) => controller.validatephoneNumber(value),
      controller: controller.phoneNumberController,
      decoration: buildInputDecoration(
          hintText: "kphonenumberhint".tr,
          prefixIconImage: "telephone.png",
          labelText: "kphonenumber".tr),
      style: GoogleFonts.nunitoSans(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: typingColor,
      ),
    );
  }

  Row buildGenderFormField(CompleteProfileController controller) {
    return Row(
      children: [
        Expanded(
          child: RadioListTile<String>(
            activeColor: primaryColor,
            title: Text('kmale'.tr),
            value: 'Male',
            groupValue: controller.gender,
            onChanged: (value) => controller.onChangedGender(value),
          ),
        ),
        Expanded(
          child: RadioListTile<String>(
            activeColor: primaryColor,
            title: Text('kfemale'.tr),
            value: 'Female',
            groupValue: controller.gender,
            onChanged: (value) => controller.onChangedGender(value),
          ),
        ),
      ],
    );
  }

  TextFormField buildAddressFormField(CompleteProfileController controller) {
    return TextFormField(
      onSaved: (newValue) => controller.adressController.text = newValue!,
      controller: controller.adressController,
      decoration: buildInputDecoration(
          hintText: "kaddresshint".tr,
          prefixIconImage: "place.png",
          labelText: "kaddress".tr),
      style: GoogleFonts.nunitoSans(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: typingColor,
      ),
    );
  }

  TextFormField buildVerificationFormField(
      CompleteProfileController controller) {
    return TextFormField(
      onSaved: (newValue) => controller.veriffiactionControler.text = newValue!,
      controller: controller.veriffiactionControler,
      decoration: buildInputDecoration(
          hintText: "Please enter your medicale license code".tr,
          prefixIconImage: "place.png",
          labelText: "Medicale license code"),
      style: GoogleFonts.nunitoSans(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: typingColor,
      ),
    );
  }

  TextFormField builddescriptionFormField(
      CompleteProfileController controller) {
    return TextFormField(
      onSaved: (newValue) => controller.descriptionController.text = newValue!,
      onChanged: (value) => controller.onChangeddescription(value),
      validator: (value) => controller.validatedescription(value),
      controller: controller.descriptionController,
      maxLines: 3,
      decoration: buildInputDecoration(
          hintText: "kAbouthint".tr,
          prefixIconImage: "place.png",
          labelText: "kAbout".tr),
      style: GoogleFonts.nunitoSans(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: typingColor,
      ),
    );
  }
}

DropdownButtonFormField<String?> buildspecializationFormField(
  CompleteProfileController controller,
) {
  final List<Specialite> specialities = specialiste;

  assert(specialities.toSet().length == specialities.length);

  Specialite? defaultValue = specialities.first;

  if (!specialities.contains(defaultValue)) {
    defaultValue = null;
  }

  return DropdownButtonFormField<String?>(
    value: defaultValue?.name,
    onChanged: (value) => controller.onChangeSpecialite(value),
    items: [
      const DropdownMenuItem<String?>(
        value: null,
        child: Text('None'),
      ),
      if (specialities.isNotEmpty)
        ...specialities.map(
          (speciality) => DropdownMenuItem<String?>(
            value: speciality.name,
            child: Text(speciality.name),
          ),
        ),
    ],
    decoration: const InputDecoration(
      labelText: "Specialization",
      floatingLabelBehavior: FloatingLabelBehavior.always,
    ),
  );
}
