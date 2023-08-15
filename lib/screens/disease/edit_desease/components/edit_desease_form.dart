import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:medilink_app/components/custom_button.dart';
import 'package:medilink_app/components/texte_field_label.dart';
import 'package:medilink_app/models/disease.dart';
import 'package:medilink_app/screens/disease/edit_desease/edit_desease_controller.dart';
import 'package:medilink_app/utils/constants.dart';

class EditDiseaseForm extends StatelessWidget {
  const EditDiseaseForm({super.key, required this.disease});
  final Disease disease;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditDiseaseController>(
        init: EditDiseaseController(disease: disease),
        builder: (controller) {
          return Form(
              key: controller.formKeyEditDisease,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextFieldLabel(label: 'Disease Name'),
                  const SizedBox(height: 4),
                  buildTestFormField(controller),
                  SizedBox(height: 6.h),
                  const TextFieldLabel(label: 'Speciality'),
                  const SizedBox(height: 4),
                  buildspecialityFormField(controller),
                  SizedBox(height: 6.h),

                  const TextFieldLabel(label: 'Severity'),
                  const SizedBox(height: 4),
                  buildseverityFormField(controller),
                  SizedBox(height: 6.h),

                  const TextFieldLabel(label: 'Genetic'),
                  const SizedBox(height: 4),
                  buildgeneticFormField(controller),
                  SizedBox(height: 6.h),

                  const TextFieldLabel(label: 'Chronic Disease'),
                  const SizedBox(height: 4),
                  buildchronicDiseaseFormField(controller),
                  SizedBox(height: 6.h),

                  const TextFieldLabel(label: 'Detected In'),
                  const SizedBox(height: 4),
                  builddetectedFormField(context, controller),
                  SizedBox(height: 6.h),

                  const TextFieldLabel(label: 'Cured In'),
                  const SizedBox(height: 4),
                  buildcuredInFormField(context, controller),
                  SizedBox(height: 6.h),

                  const TextFieldLabel(label: 'Symptoms'),
                  const SizedBox(height: 4),
                  buildsymptomsFormField(controller),
                  SizedBox(height: 6.h),

                  const TextFieldLabel(label: 'Medications'),
                  const SizedBox(height: 4),
                  buildmedicationsFormField(controller),
                  SizedBox(height: 6.h),
                  const TextFieldLabel(label: 'Family History'),
                  const SizedBox(height: 4),
                  buildchronicDiseaseFormField(controller),
                  SizedBox(height: 6.h),
                  const TextFieldLabel(label: 'Recurrence'),
                  const SizedBox(height: 4),
                  buildchronicDiseaseFormField(controller),
                  SizedBox(height: 6.h),

                  const TextFieldLabel(label: 'Notes'),
                  const SizedBox(height: 4),
                  buildnotesFormField(controller),
                  SizedBox(height: 10.h),
                  //FormError(errors: controller.errors),
                  Obx(() {
                    return CustomButton(
                      buttonText: "kbutton1".tr,
                      onPress: () async {
                        controller.editdisease();
                      },
                      isLoading: controller.isLoading.value,
                    );
                  }),
                ],
              ));
        });
  }
}

Row buildgeneticFormField(EditDiseaseController controller) {
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
              groupValue: controller.genetic.value,
              onChanged: (value) => controller.onChangedgenetic(value!),
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
              groupValue: controller.genetic.value,
              onChanged: (value) => controller.onChangedgenetic(value!),
            )),
      ),
    ],
  );
}

Row buildchronicDiseaseFormField(EditDiseaseController controller) {
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
              groupValue: controller.chronicDisease.value,
              onChanged: (value) => controller.onChangedchronicDisease(value!),
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
              groupValue: controller.chronicDisease.value,
              onChanged: (value) => controller.onChangedchronicDisease(value!),
            )),
      ),
    ],
  );
}

Row buildfamilyHistoryFormField(EditDiseaseController controller) {
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

Row buildrecurrenceFormField(EditDiseaseController controller) {
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
              groupValue: controller.recurrence.value,
              onChanged: (value) => controller.onChangedrecurrence(value!),
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
              groupValue: controller.recurrence.value,
              onChanged: (value) => controller.onChangedrecurrence(value!),
            )),
      ),
    ],
  );
}

TextFormField buildTestFormField(EditDiseaseController controller) {
  return TextFormField(
    controller: controller.diseaseNameController,
    style: TextStyle(
      color: typingColor.withOpacity(0.85),
      fontWeight: FontWeight.w600,
    ),
    decoration: InputDecoration(
      hintText: 'Enter the Disease name',
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
    validator: (value) => controller.validatediseaseName(value),
    onChanged: (value) => controller.onChangeddiseaseName(value),
  );
}

TextFormField buildspecialityFormField(EditDiseaseController controller) {
  return TextFormField(
    controller: controller.specialityController,
    style: TextStyle(
      color: typingColor.withOpacity(0.85),
      fontWeight: FontWeight.w600,
    ),
    decoration: InputDecoration(
      hintText: 'Enter the Speciality name',
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
    validator: (value) => controller.validatespeciality(value),
    onChanged: (value) => controller.onChangedspeciality(value),
  );
}

TextFormField buildsymptomsFormField(EditDiseaseController controller) {
  return TextFormField(
    controller: controller.symptomsController,
    style: TextStyle(
      color: typingColor.withOpacity(0.85),
      fontWeight: FontWeight.w600,
    ),
    decoration: InputDecoration(
      hintText: 'Enter the symptoms name',
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
    validator: (value) => controller.validatediseaseName(value),
    onChanged: (value) => controller.onChangeddiseaseName(value),
  );
}

TextFormField buildmedicationsFormField(EditDiseaseController controller) {
  return TextFormField(
    controller: controller.medicationsController,
    style: TextStyle(
      color: typingColor.withOpacity(0.85),
      fontWeight: FontWeight.w600,
    ),
    decoration: InputDecoration(
      hintText: 'Enter the used medications',
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
    validator: (value) => controller.validatespeciality(value),
    onChanged: (value) => controller.onChangedspeciality(value),
  );
}

TextFormField buildnotesFormField(EditDiseaseController controller) {
  return TextFormField(
    controller: controller.notesController,
    style: TextStyle(
      color: typingColor.withOpacity(0.85),
      fontWeight: FontWeight.w600,
    ),
    decoration: InputDecoration(
      hintText: 'Enter the notes',
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
    validator: (value) => controller.validatespeciality(value),
    onChanged: (value) => controller.onChangedspeciality(value),
  );
}

DropdownButtonFormField<String?> buildseverityFormField(
  EditDiseaseController controller,
) {
  final List<String> specialities = controller.severity;

  assert(specialities.toSet().length == specialities.length);

  String? defaultValue = controller.disease.severity;

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

TextFormField buildcuredInFormField(
    BuildContext context, EditDiseaseController controller) {
  return TextFormField(
    controller: controller.curedInController,
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
        controller.curedInController.text = formattedDate;
      }
    },
    decoration: const InputDecoration(
      labelText: "Cured In year",
      hintText: "Enter the Cured In year",
      floatingLabelBehavior: FloatingLabelBehavior.always,
    ),
    validator: (value) => controller.validatecuredIn(value),
  );
}

TextFormField builddetectedFormField(
    BuildContext context, EditDiseaseController controller) {
  return TextFormField(
    controller: controller.detectedInController,
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
        controller.detectedInController.text = formattedDate;
      }
    },
    decoration: const InputDecoration(
      labelText: "Detection year",
      hintText: "Enter the year of detection",
      floatingLabelBehavior: FloatingLabelBehavior.always,
    ),
    validator: (value) => controller.validatedetectedIn(value),
  );
}
