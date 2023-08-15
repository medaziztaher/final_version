import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:medilink_app/components/custom_button.dart';
import 'package:medilink_app/components/texte_field_label.dart';
import 'package:medilink_app/models/surgery.dart';
import 'package:medilink_app/screens/search/search_screen.dart';
import 'package:medilink_app/screens/surgery/edit_surgery/components/edit_surgerie_files.dart';
import 'package:medilink_app/screens/surgery/edit_surgery/edit_surgery_controller.dart';
import 'package:medilink_app/utils/constants.dart';

class EditSurgerieForm extends StatelessWidget {
  const EditSurgerieForm(
      {super.key, required this.surgerie, required this.userId});
  final Surgery surgerie;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditSurgerieController>(
        init: EditSurgerieController(surgerie: surgerie),
        builder: (controller) {
          return Form(
            key: controller.formKeyEditSurgerie,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextFieldLabel(label: 'Surgerie Type'),
                const SizedBox(
                  height: 4,
                ),
                buildTestFormField(controller),
                SizedBox(height: 15.h),

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
                SizedBox(height: 15.h),
                const TextFieldLabel(label: 'Outcome'),
                const SizedBox(
                  height: 4,
                ),
                buildoutcomeFormField(controller),
                const TextFieldLabel(label: 'Anesthesia'),
                const SizedBox(
                  height: 4,
                ),
                buildReasonFormField(controller),
                if (userId == surgerie.patient) ...[
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
                EditSurgerieFiles(surgerie: surgerie),
                SizedBox(height: 15.h),
                //FormError(errors: controller.errors),
                // SizedBox(height: getProportionateScreenWidth(40)),
                Obx(() {
                  return CustomButton(
                    buttonText: "kbutton1".tr,
                    onPress: () async {
                      controller.updateSurgerie();
                    },
                    isLoading: controller.isLoading.value,
                  );
                }),
              ],
            ),
          );
        });
  }
}

TextFormField buildTestFormField(EditSurgerieController controller) {
  return TextFormField(
    controller: controller.typeController,
    style: TextStyle(
      color: typingColor.withOpacity(0.85),
      fontWeight: FontWeight.w600,
    ),
    decoration: InputDecoration(
      hintText: 'Enter the Surgery type',
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

TextFormField builddescriptionFormField(EditSurgerieController controller) {
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

TextFormField buildReasonFormField(EditSurgerieController controller) {
  return TextFormField(
    controller: controller.anesthesiaController,
    style: TextStyle(
      color: typingColor.withOpacity(0.85),
      fontWeight: FontWeight.w600,
    ),
    decoration: InputDecoration(
      hintText: 'Enter the anesthesia used during the surgery',
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
    /*validator: (value) => controller.validatereason(value),
    onChanged: (value) => controller.onChangedreason(value),*/
  );
}

TypeAheadFormField<String> buildSharedWithFormField(
  EditSurgerieController controller,
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
    BuildContext context, EditSurgerieController controller) {
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

Widget buildSelectedUsersChips(EditSurgerieController controller) {
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

TextFormField buildoutcomeFormField(EditSurgerieController controller) {
  return TextFormField(
    controller: controller.complicationsController,
    style: TextStyle(
      color: typingColor.withOpacity(0.85),
      fontWeight: FontWeight.w600,
    ),
    decoration: InputDecoration(
      hintText: 'Enter the Outcome ',
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
    validator: (value) => controller.validatecomplications(value),
    onChanged: (value) => controller.onChangedcomplications(value),
  );
}
