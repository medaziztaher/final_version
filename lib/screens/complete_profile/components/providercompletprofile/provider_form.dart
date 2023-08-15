import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilink_app/components/custom_button.dart';
import 'package:medilink_app/components/texte_field_label.dart';
import 'package:medilink_app/screens/authentification/signup/components/signup_form.dart';
import 'package:medilink_app/screens/complete_profile/components/profile_img.dart';
import 'package:medilink_app/utils/constants.dart';

import '../../complete_profile_controller.dart';
import '../building_images.dart';

class ProviderForm extends StatelessWidget {
  const ProviderForm({super.key});

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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const TextFieldLabel(
                                    label: "Address",
                                  ),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  buildAddressFormField(controller),
                                  SizedBox(
                                    height: 18.h,
                                  ),
                                  const TextFieldLabel(
                                    label: "Phone Number",
                                  ),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  buildPhoneNumberFormField(controller),
                                  SizedBox(
                                    height: 18.h,
                                  ),
                                  const TextFieldLabel(
                                    label: "Medical licence",
                                  ),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  buildVerificationFormField(controller),
                                  SizedBox(
                                    height: 18.h,
                                  ),
                                  const TextFieldLabel(
                                    label: " Pictures",
                                  ),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  const BuildingImages(),
                                  SizedBox(
                                    height: 26.h,
                                  ),
                                  CustomButton(
                                    buttonText: "kbutton1".tr,
                                    isLoading: controller.isLoading.value,
                                    onPress: () async {
                                      controller.completeProfile();
                                    },
                                  ),
                                ]));
                      }),
                ])));
  }

  TextFormField buildAddressFormField(CompleteProfileController controller) {
    return TextFormField(
      onSaved: (newValue) => controller.adressController.text = newValue!,
      controller: controller.adressController,
      decoration: buildInputDecoration(
        hintText: "kaddresshint".tr,
        prefixIconImage: "location.png",
      ),
      style: GoogleFonts.nunitoSans(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: typingColor,
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
      ),
      style: GoogleFonts.nunitoSans(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: typingColor,
      ),
    );
  }
}

TextFormField buildVerificationFormField(CompleteProfileController controller) {
  return TextFormField(
    onSaved: (newValue) => controller.veriffiactionControler.text = newValue!,
    controller: controller.veriffiactionControler,
    decoration: buildInputDecoration(
      hintText: "Please enter your medicale license code".tr,
      prefixIconImage: "licence.png",
    ),
    style: GoogleFonts.nunitoSans(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: typingColor,
    ),
  );
}
