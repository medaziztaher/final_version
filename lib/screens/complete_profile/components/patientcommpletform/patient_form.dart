import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:medilink_app/components/custom_button.dart';
import 'package:medilink_app/components/texte_field_label.dart';
import 'package:medilink_app/screens/authentification/signup/components/signup_form.dart';
import 'package:medilink_app/utils/constants.dart';

import '../../complete_profile_controller.dart';
import '../profile_img.dart';

class PatienForm extends StatelessWidget {
  const PatienForm({Key? key}) : super(key: key);

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
                        const TextFieldLabel(label: "Gender"),
                        SizedBox(
                          height: 6.h,
                        ),
                        buildGenderFormField(controller),
                        SizedBox(
                          height: 18.h,
                        ),
                        const TextFieldLabel(label: "Address"),
                        SizedBox(
                          height: 6.h,
                        ),
                        buildAddressFormField(controller),
                        SizedBox(
                          height: 18.h,
                        ),
                        const TextFieldLabel(label: "Phone Number"),
                        SizedBox(
                          height: 6.h,
                        ),
                        buildPhoneNumberFormField(controller),
                        SizedBox(
                          height: 18.h,
                        ),
                        const TextFieldLabel(label: "Birth Date"),
                        SizedBox(
                          height: 6.h,
                        ),
                        buildbirthdateField(context, controller),
                        SizedBox(
                          height: 18.h,
                        ),
                        const TextFieldLabel(label: "Status"),
                        SizedBox(
                          height: 6.h,
                        ),
                        buildTypeFormField(controller),
                        SizedBox(
                          height: 18.h,
                        ),
                        Visibility(
                            visible: controller.etatcivil != 'Single',
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TextFieldLabel(
                                    label: "Number of childrens"),
                                SizedBox(
                                  height: 6.h,
                                ),
                                buildnemberdenfant(controller),
                              ],
                            )),
                        SizedBox(
                          height: 26.h,
                        ),
                        Obx(() {
                          return CustomButton(
                              buttonText: "kbutton1".tr,
                              isLoading: controller.isLoading.value,
                              onPress: () async {
                                controller.completeProfile();
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
          labelText: ''),
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
            title: Text(
              'kmale'.tr,
              style: GoogleFonts.nunitoSans(
                color: typingColor,
              ),
            ),
            value: 'Male',
            groupValue: controller.gender,
            onChanged: (value) => controller.onChangedGender(value),
          ),
        ),
        Expanded(
          child: RadioListTile<String>(
            activeColor: primaryColor,
            title: Text(
              'kfemale'.tr,
              style: GoogleFonts.nunitoSans(
                color: typingColor,
              ),
            ),
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
          prefixIconImage: "location.png",
          labelText: ''),
      style: GoogleFonts.nunitoSans(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: typingColor,
      ),
    );
  }

  DropdownButtonFormField<String> buildTypeFormField(
      CompleteProfileController controller) {
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
      decoration: buildInputDecoration(
          hintText: "Civil State".tr,
          prefixIconImage: "status.png",
          labelText: ''),
      style: GoogleFonts.nunitoSans(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: typingColor,
      ),
    );
  }

  TextFormField buildnemberdenfant(CompleteProfileController controller) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) =>
          controller.nembredenfantController.text = newValue!,
      controller: controller.nembredenfantController,
      decoration: buildInputDecoration(
          hintText: "Nombre d'enfants".tr,
          prefixIconImage: "children.png",
          labelText: ''),
      style: GoogleFonts.nunitoSans(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: typingColor,
      ),
    );
  }

  TextFormField buildbirthdateField(
      BuildContext context, CompleteProfileController controller) {
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
      decoration: buildInputDecoration(
          hintText: "kbirthdate".tr,
          prefixIconImage: "calendar.png",
          labelText: ''),
      style: GoogleFonts.nunitoSans(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: typingColor,
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
