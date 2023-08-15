import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:medilink_app/components/custom_button.dart';
import 'package:medilink_app/components/texte_field_label.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/screens/radiographie/add_radiographie/components/radiographie_file.dart';
import 'package:medilink_app/screens/search/search_screen.dart';
import 'package:medilink_app/screens/surgery/add_surgery/add_surgery_controller.dart';
import 'package:medilink_app/utils/constants.dart';

class AddSurgerieForm extends StatelessWidget {
  const AddSurgerieForm({super.key, required this.user, required this.userId});
  final User user;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddSurgerieController>(
      init: AddSurgerieController(user: user),
      builder: (controller) {
        return Form(
          key: controller.surgeryformKey,
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
              if (userId == user.id) ...[
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
              RadioFiles(user: user),
              SizedBox(height: 15.h),
              //FormError(errors: controller.errors),
              // SizedBox(height: getProportionateScreenWidth(40)),
              Obx(() {
                return CustomButton(
                  buttonText: "kbutton1".tr,
                  onPress: () async {
                    controller.addSurgerie();
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

TextFormField buildTestFormField(AddSurgerieController controller) {
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

TextFormField builddescriptionFormField(AddSurgerieController controller) {
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

TextFormField buildReasonFormField(AddSurgerieController controller) {
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
  AddSurgerieController controller,
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
    BuildContext context, AddSurgerieController controller) {
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

Widget buildSelectedUsersChips(AddSurgerieController controller) {
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

TextFormField buildoutcomeFormField(AddSurgerieController controller) {
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
