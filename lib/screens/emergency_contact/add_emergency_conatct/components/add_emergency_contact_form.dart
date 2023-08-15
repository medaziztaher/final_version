import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilink_app/components/texte_field_label.dart';
import 'package:medilink_app/screens/emergency_contact/add_emergency_conatct/add_emergency_contact_controller.dart';
import 'package:medilink_app/screens/emergency_contact/add_emergency_conatct/components/emergency_contact_picture.dart';
import 'package:medilink_app/utils/constants.dart';

class EmergencyContactForm extends StatelessWidget {
  const EmergencyContactForm({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmergencyContactController>(
        init: EmergencyContactController(),
        builder: (controller) {
          return Form(
              key: controller.formKeyEmCo,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      EmergencyContactPic(),
                    ],
                  ),
                  SizedBox(
                    height: 26.h,
                  ),
                  const TextFieldLabel(label: "Name"),
                  SizedBox(
                    height: 6.h,
                  ),
                  buildnameFormField(controller),
                  SizedBox(
                    height: 18.h,
                  ),
                  const TextFieldLabel(label: "Relation"),
                  SizedBox(
                    height: 6.h,
                  ),
                  buildrealtionFormField(controller),
                  SizedBox(
                    height: 18.h,
                  ),
                  const TextFieldLabel(label: "Phone Number"),
                  SizedBox(
                    height: 6.h,
                  ),
                  buildPhoneNumberFormField(controller),
                  SizedBox(
                    height: 12.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Obx(() {
                        if (controller.isLoading.value == false) {
                          return GestureDetector(
                            onTap: () {
                              controller.addEmergencyContact();
                            },
                            child: Text(
                              "Add another emergency contact",
                              style: GoogleFonts.nunitoSans(
                                decoration: TextDecoration.underline,
                                fontSize: 16.sp,
                                color: typingColor.withOpacity(0.75),
                              ),
                            ),
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator(
                            color: primaryColor,
                          ));
                        }
                      }),
                    ],
                  ),
                ],
              ));
        });
  }
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

TextFormField buildPhoneNumberFormField(EmergencyContactController controller) {
  return TextFormField(
    keyboardType: TextInputType.phone,
    onSaved: (newValue) => controller.phoneNumberController.text = newValue!,
    onChanged: (value) => controller.onChangedphonenumber(value),
    validator: (value) => controller.validatephoneNumber(value),
    controller: controller.phoneNumberController,
    decoration: buildInputDecoration(
        hintText: "kphonenumberhint".tr, prefixIconImage: "telephone.png"),
    style: GoogleFonts.nunitoSans(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: typingColor,
    ),
  );
}

TextFormField buildnameFormField(EmergencyContactController controller) {
  return TextFormField(
    onSaved: (newValue) => controller.nameController.text = newValue!,
    onChanged: (value) => controller.onChangedname(value),
    validator: (value) => controller.validateName(value),
    controller: controller.nameController,
    decoration: buildInputDecoration(
        hintText: "knamehint".tr, prefixIconImage: "person.png"),
    style: GoogleFonts.nunitoSans(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: typingColor,
    ),
  );
}

TextFormField buildrealtionFormField(EmergencyContactController controller) {
  return TextFormField(
    onSaved: (newValue) => controller.relationshipController.text = newValue!,
    onChanged: (value) => controller.onChangedrelation(value),
    validator: (value) => controller.validateRelation(value),
    controller: controller.relationshipController,
    decoration: buildInputDecoration(
        hintText: "Relationship".tr, prefixIconImage: "status.png"),
    style: GoogleFonts.nunitoSans(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: typingColor,
    ),
  );
}
