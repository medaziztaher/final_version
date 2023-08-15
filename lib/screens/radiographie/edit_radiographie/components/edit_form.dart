import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:medilink_app/components/custom_button.dart';
import 'package:medilink_app/components/texte_field_label.dart';
import 'package:medilink_app/models/radiographie.dart';
import 'package:medilink_app/screens/radiographie/edit_radiographie/components/edit_file.dart';
import 'package:medilink_app/screens/radiographie/edit_radiographie/edit_radiographie_controller.dart';
import 'package:medilink_app/screens/search/search_screen.dart';
import 'package:medilink_app/utils/constants.dart';

class EditRadioForm extends StatelessWidget {
  const EditRadioForm(
      {super.key, required this.radiographie, required this.userId});
  final Radiographie radiographie;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditRadioController>(
        init: EditRadioController(radiographie: radiographie),
        builder: (controller) {
          return Form(
              key: controller.formKeyEditRadio,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextFieldLabel(label: 'Test Name'),
                  const SizedBox(
                    height: 4,
                  ),
                  buildTestFormField(controller),
                  SizedBox(height: 15.h),
                  const TextFieldLabel(label: 'Reason'),
                  const SizedBox(
                    height: 4,
                  ),
                  buildReasonFormField(controller),
                  SizedBox(height: 15.h),
                  const TextFieldLabel(label: 'Date'),
                  const SizedBox(
                    height: 4,
                  ),
                  buildDateFormField(context, controller),
                  SizedBox(height: 15.h),
                  const TextFieldLabel(label: 'Description'),
                  const SizedBox(
                    height: 4,
                  ),
                  builddescriptionFormField(controller),
                  if (userId == radiographie.id) ...[
                    SizedBox(height: 15.h),
                    const TextFieldLabel(label: 'Shared with'),
                    const SizedBox(
                      height: 4,
                    ),
                    buildSharedWithFormField(controller),
                    if (controller.selectedUsers.isNotEmpty) ...[
                      buildSelectedUsersChips(controller),
                    ],
                    SizedBox(height: 15.h),
                  ],
                  EditRadioFile(radiographie: radiographie),
                  SizedBox(height: 15.h),
                  //FormError(errors: controller.errors),
                  // SizedBox(height: getProportionateScreenWidth(40)),
                  Obx(() {
                    return CustomButton(
                      buttonText: "kbutton1".tr,
                      onPress: () async {
                        controller.updateRadiographie();
                      },
                      isLoading: controller.isLoading.value,
                    );
                  }),
                ],
              ));
        });
  }
}

TextFormField buildTestFormField(EditRadioController controller) {
  return TextFormField(
    controller: controller.typeController,
    style: TextStyle(
      color: typingColor.withOpacity(0.85),
      fontWeight: FontWeight.w600,
    ),
    decoration: InputDecoration(
      hintText: 'Enter the Radiographi type',
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      hintStyle: GoogleFonts.nunitoSans(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: typingColor.withOpacity(0.8),
      ),
    ),
    validator: (value) => controller.validatetype(value),
    onChanged: (value) => controller.onChangedtype(value),
  );
}

TextFormField builddescriptionFormField(EditRadioController controller) {
  return TextFormField(
    controller: controller.descriptionController,
    style: TextStyle(
      color: typingColor.withOpacity(0.85),
      fontWeight: FontWeight.w600,
    ),
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      hintStyle: GoogleFonts.nunitoSans(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: typingColor.withOpacity(0.8),
      ),
      hintText: 'Enter the description',
    ),
    maxLines: 3,
    validator: (value) => controller.validatedescription(value),
    onChanged: (value) => controller.onChangeddescription(value),
  );
}

TextFormField buildReasonFormField(EditRadioController controller) {
  return TextFormField(
    controller: controller.reasonController,
    style: TextStyle(
      color: typingColor.withOpacity(0.85),
      fontWeight: FontWeight.w600,
    ),
    decoration: InputDecoration(
      hintText: 'Enter the reason',
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      hintStyle: GoogleFonts.nunitoSans(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: typingColor.withOpacity(0.8),
      ),
    ),
    validator: (value) => controller.validatereason(value),
    onChanged: (value) => controller.onChangedreason(value),
  );
}

TypeAheadFormField<String> buildSharedWithFormField(
  EditRadioController controller,
) {
  return TypeAheadFormField<String>(
    textFieldConfiguration: TextFieldConfiguration(
      controller: controller.selectedUsersController,
      style: TextStyle(
        color: typingColor.withOpacity(0.85),
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        hintText: 'Search and select doctors',
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        hintStyle: GoogleFonts.nunitoSans(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: typingColor.withOpacity(0.8),
        ),
      ),
    ),
    suggestionsCallback: (pattern) async {
      if (pattern.isNotEmpty) {
        final suggestions = await controller.fetchHealthcareProviders(pattern);
        return suggestions;
      } else {
        return [];
      }
    },
    itemBuilder: (context, suggestion) {
      return ListTile(
        title: Text(suggestion),
      );
    },
    onSuggestionSelected: (suggestion) {
      controller.addUserToSharedWith(suggestion);
      controller.selectedUsersController.clear();
    },
    noItemsFoundBuilder: (context) {
      return ListTile(
        title: SingleChildScrollView(
          child: Column(
            children: [
              const Text("You don't have any doctors"),
              SizedBox(height: 6.h),
              GestureDetector(
                child: const Text(
                  "Add doctor",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () => Get.off(() => SearchScreen()),
              ),
            ],
          ),
        ),
      );
    },
  );
}

TextFormField buildDateFormField(
    BuildContext context, EditRadioController controller) {
  return TextFormField(
    controller: controller.dateController,
    style: TextStyle(
      color: typingColor.withOpacity(0.85),
      fontWeight: FontWeight.w600,
    ),
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
        controller.dateController.text = formattedDate;
      }
    },
    decoration: InputDecoration(
      hintText: 'Enter the date',
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      hintStyle: GoogleFonts.nunitoSans(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: typingColor.withOpacity(0.8),
      ),
    ),
    validator: (value) => controller.validatedate(value),
  );
}

Widget buildSelectedUsersChips(EditRadioController controller) {
  return Wrap(
    spacing: 8.0,
    runSpacing: 4.0,
    children: controller.selectedUsers.map((user) {
      return Chip(
        label: Text(user),
        onDeleted: () => controller.removeUserFromSharedWith(user),
        backgroundColor: lightBlueColor,
        deleteIconColor: Colors.red,
        labelStyle: const TextStyle(color: Colors.black),
      );
    }).toList(),
  );
}
