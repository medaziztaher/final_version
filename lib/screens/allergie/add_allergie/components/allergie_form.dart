import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:medilink_app/components/custom_button.dart';
import 'package:medilink_app/components/texte_field_label.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/screens/allergie/add_allergie/add_allergie_controller.dart';
import 'package:medilink_app/utils/constants.dart';

class AddAllergieForm extends StatelessWidget {
  const AddAllergieForm({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddAllergyController>(
        init: AddAllergyController(user: user),
        builder: (controller) {
          return Form(
            key: controller.formKeyAddAllergy,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextFieldLabel(label: 'Allergy Name'),
                const SizedBox(height: 4),
                buildTestFormField(controller),
                SizedBox(height: 6.h),
                const TextFieldLabel(label: 'Severity'),
                const SizedBox(height: 4),
                buildseverityFormField(controller),
                SizedBox(height: 6.h),

                const TextFieldLabel(label: 'Trigger'),
                const SizedBox(height: 4),
                buildtriggerFormField(controller),
                SizedBox(height: 6.h),

                const TextFieldLabel(label: 'Reaction'),
                const SizedBox(height: 4),
                buildreactionFormField(controller),
                SizedBox(height: 6.h),

                const TextFieldLabel(label: 'Year Of Discovery'),
                const SizedBox(height: 4),
                builddateField(context, controller),
                SizedBox(height: 6.h),

                const TextFieldLabel(label: 'Onset'),
                const SizedBox(height: 4),
                buildOnsetFormField(controller),
                SizedBox(height: 6.h),

                const TextFieldLabel(label: 'Follow up Status'),
                const SizedBox(height: 4),
                buildfollowupStatusFormField(controller),
                SizedBox(height: 6.h),

                const TextFieldLabel(label: 'Family History'),
                const SizedBox(height: 4),
                buildFamilyHistoryFormField(controller),
                SizedBox(height: 6.h),

                const TextFieldLabel(label: 'Notes'),
                const SizedBox(height: 4),
                buildNoteFormField(controller),
                SizedBox(height: 10.h),

                //FormError(errors: controller.errors),
                Obx(() {
                  return CustomButton(
                    buttonText: "kbutton1".tr,
                    onPress: () async {
                      controller.addAllergy();
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

TextFormField buildTestFormField(AddAllergyController controller) {
  return TextFormField(
    controller: controller.typeController,
    style: TextStyle(
      color: typingColor.withOpacity(0.85),
      fontWeight: FontWeight.w600,
    ),
    decoration: InputDecoration(
      hintText: 'Enter the Allergy name',
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

TextFormField buildreactionFormField(AddAllergyController controller) {
  return TextFormField(
    controller: controller.reactionController,
    style: TextStyle(
      color: typingColor.withOpacity(0.85),
      fontWeight: FontWeight.w600,
    ),
    decoration: InputDecoration(
      hintText: 'Enter the Severity',
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
    validator: (value) => controller.validateReaction(value),
    onChanged: (value) => controller.onChangedReaction(value),
  );
}

TextFormField buildtriggerFormField(AddAllergyController controller) {
  return TextFormField(
    controller: controller.triggerController,
    style: TextStyle(
      color: typingColor.withOpacity(0.85),
      fontWeight: FontWeight.w600,
    ),
    decoration: InputDecoration(
      hintText: 'Specify the trigger that causes the allergic reaction',
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
    validator: (value) => controller.validatetriggerr(value),
    onChanged: (value) => controller.onChangedtrigger(value),
  );
}

TextFormField builddateField(
    BuildContext context, AddAllergyController controller) {
  return TextFormField(
    controller: controller.yearOfDiscoveryController,
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
        controller.yearOfDiscoveryController.text = formattedDate;
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

TextFormField buildNoteFormField(AddAllergyController controller) {
  return TextFormField(
    controller: controller.notesController,
    style: TextStyle(
      color: typingColor.withOpacity(0.85),
      fontWeight: FontWeight.w600,
    ),
    decoration: InputDecoration(
      hintText: 'Enter the Allergy name',
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
    validator: (value) => controller.validatenotes(value),
    onChanged: (value) => controller.onChangednotes(value),
  );
}

DropdownButtonFormField<String?> buildseverityFormField(
  AddAllergyController controller,
) {
  final List<String> specialities = controller.severity;

  assert(specialities.toSet().length == specialities.length);

  String? defaultValue = specialities.first;

  if (!specialities.contains(defaultValue)) {
    defaultValue = null;
  }

  return DropdownButtonFormField<String?>(
    value: defaultValue,
    onChanged: (value) => controller.onChangedseverity(value!),
    items: [
      const DropdownMenuItem<String?>(
        value: null,
        child: Text('None'),
      ),
      if (specialities.isNotEmpty)
        ...specialities.map(
          (speciality) => DropdownMenuItem<String?>(
            value: speciality,
            child: Text(speciality),
          ),
        ),
    ],
  );
}

DropdownButtonFormField<String?> buildOnsetFormField(
  AddAllergyController controller,
) {
  final List<String> specialities = controller.onset;

  assert(specialities.toSet().length == specialities.length);

  String? defaultValue = specialities.first;

  if (!specialities.contains(defaultValue)) {
    defaultValue = null;
  }

  return DropdownButtonFormField<String?>(
    value: defaultValue,
    onChanged: (value) => controller.onChangedonset(value!),
    items: [
      const DropdownMenuItem<String?>(
        value: null,
        child: Text('None'),
      ),
      if (specialities.isNotEmpty)
        ...specialities.map(
          (speciality) => DropdownMenuItem<String?>(
            value: speciality,
            child: Text(speciality),
          ),
        ),
    ],
  );
}

DropdownButtonFormField<String?> buildfollowupStatusFormField(
  AddAllergyController controller,
) {
  final List<String> specialities = controller.followupStatus;

  assert(specialities.toSet().length == specialities.length);

  String? defaultValue = specialities.first;

  if (!specialities.contains(defaultValue)) {
    defaultValue = null;
  }

  return DropdownButtonFormField<String?>(
    value: defaultValue,
    onChanged: (value) => controller.onChangedfollowupStatus(value!),
    items: [
      const DropdownMenuItem<String?>(
        value: null,
        child: Text('None'),
      ),
      if (specialities.isNotEmpty)
        ...specialities.map(
          (speciality) => DropdownMenuItem<String?>(
            value: speciality,
            child: Text(speciality),
          ),
        ),
    ],
  );
}

Row buildFamilyHistoryFormField(AddAllergyController controller) {
  return Row(
    children: [
      Expanded(
        flex: 2,
        child: Obx(() => RadioListTile<bool>(
              title: const Text(
                "Yes",
                style: TextStyle(fontSize: 16),
              ),
              value: true,
              groupValue: controller.familyHistory.value,
              onChanged: (value) => controller.onChangedfamilyHistory(value!),
            )),
      ),
      Expanded(
        flex: 3,
        child: Obx(() => RadioListTile<bool>(
              title: const Text(
                'No',
                style: TextStyle(fontSize: 16),
              ),
              value: false,
              groupValue: controller.familyHistory.value,
              onChanged: (value) => controller.onChangedfamilyHistory(value!),
            )),
      ),
    ],
  );
}
