import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:medilink_app/components/custom_button.dart';
import 'package:medilink_app/components/texte_field_label.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/screens/analyse/add_analyse/add_analyse_controller.dart';
import 'package:medilink_app/screens/analyse/add_analyse/components/files.dart';
import 'package:medilink_app/screens/search/search_screen.dart';
import 'package:medilink_app/utils/constants.dart';

class AddAnalyseForm extends StatelessWidget {
  const AddAnalyseForm({super.key, required this.user, required this.userId});
  final User user;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddAnalyseController>(
      init: AddAnalyseController(user: user),
      builder: (controller) {
        return Form(
          key: controller.labformKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextFieldLabel(label: 'Test Name'),
              const SizedBox(
                height: 4,
              ),
              buildTestFormField(controller),
              SizedBox(height: 10.h),
              const TextFieldLabel(label: 'Reason'),
              const SizedBox(
                height: 4,
              ),
              buildReasonFormField(controller),
              SizedBox(height: 10.h),
              const TextFieldLabel(label: 'Result'),
              const SizedBox(
                height: 4,
              ),
              buildResultFormField(controller),
              SizedBox(height: 10.h),
              const TextFieldLabel(label: 'Date'),
              const SizedBox(
                height: 4,
              ),
              buildDateFormField(context, controller),
              SizedBox(height: 10.h),
              const TextFieldLabel(label: 'Units (optional)'),
              const SizedBox(
                height: 4,
              ),
              buildUnitsFormField(controller),
              SizedBox(height: 10.h),
              const TextFieldLabel(label: 'ReferenceRange (optional)'),
              const SizedBox(
                height: 4,
              ),
              buildReferenceRangeFormField(controller),
              SizedBox(height: 10.h),
              const TextFieldLabel(label: 'AbnormalFlag (optional)'),
              const SizedBox(
                height: 4,
              ),
              buildabnormalFlagFormField(controller),
              if (userId == user.id) ...[
                SizedBox(height: 10.h),
                const TextFieldLabel(label: 'Shared with'),
                const SizedBox(
                  height: 4,
                ),
                buildSharedWithFormField(controller),
                if (controller.selectedUsers.isNotEmpty) ...[
                  buildSelectedUsersChips(controller),
                ],
                SizedBox(height: 10.h),
              ],
              AnalyseFiles(user: user),
              SizedBox(height: 10.h),
              //FormError(errors: controller.errors),
              // SizedBox(height: getProportionateScreenWidth(40)),
              Obx(() {
                return CustomButton(
                  buttonText: "kbutton1".tr,
                  onPress: () async {
                    controller.addLaboratoryResult();
                  },
                  isLoading: controller.isLoading.value,
                );
              }),
            ],
          ),
        );
      },
    );
  }
}

TextFormField buildTestFormField(AddAnalyseController controller) {
  return TextFormField(
    controller: controller.testNameController,
    style: TextStyle(
      color: typingColor.withOpacity(0.85),
      fontWeight: FontWeight.w600,
    ),
    decoration: InputDecoration(
      hintText: 'Enter the test name',
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
    validator: (value) => controller.validatetest(value),
    onChanged: (value) => controller.onChangedtest(value),
  );
}

TextFormField buildResultFormField(AddAnalyseController controller) {
  return TextFormField(
    controller: controller.resultController,
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
      hintText: 'Enter the lab result',
    ),
    maxLines: 3,
    validator: (value) => controller.validateresult(value),
    onChanged: (value) => controller.onChangedresult(value),
  );
}

TextFormField buildReasonFormField(AddAnalyseController controller) {
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
  AddAnalyseController controller,
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
      if (pattern.length >= 1) {
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
              SizedBox(height: 7.h),
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
    BuildContext context, AddAnalyseController controller) {
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

Widget buildSelectedUsersChips(AddAnalyseController controller) {
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

TextFormField buildUnitsFormField(AddAnalyseController controller) {
  return TextFormField(
    controller: controller.unitsController,
    style: TextStyle(
      color: typingColor.withOpacity(0.85),
      fontWeight: FontWeight.w600,
    ),
    decoration: InputDecoration(
      hintText: 'specifies the units of measurement used for the lab result',
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
  );
}

TextFormField buildReferenceRangeFormField(AddAnalyseController controller) {
  return TextFormField(
    controller: controller.referenceRangeController,
    style: TextStyle(
      color: typingColor.withOpacity(0.85),
      fontWeight: FontWeight.w600,
    ),
    decoration: InputDecoration(
      hintText: 'specifies the reference range for the laboratory result',
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
  );
}

Row buildabnormalFlagFormField(AddAnalyseController controller) {
  return Row(
    children: [
      Expanded(
        flex: 2,
        child: Obx(() => RadioListTile<bool>(
              title: Text(
                "Yes",
                style: TextStyle(fontSize: 10.h),
              ),
              value: true,
              groupValue: controller.abnormalFlag.value,
              onChanged: (value) => controller.onChangedabnormalFlag(value!),
            )),
      ),
      Expanded(
        flex: 3,
        child: Obx(() => RadioListTile<bool>(
              title: Text(
                'No',
                style: TextStyle(fontSize: 10.h),
              ),
              value: false,
              groupValue: controller.abnormalFlag.value,
              onChanged: (value) => controller.onChangedabnormalFlag(value!),
            )),
      ),
    ],
  );
}
