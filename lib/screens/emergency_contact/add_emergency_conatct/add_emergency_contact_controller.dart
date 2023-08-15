import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/screens/home/home_screen.dart';
import 'package:medilink_app/settings/networkhandler.dart';

class EmergencyContactController extends GetxController {
  GlobalKey<FormState> formKeyEmCo = GlobalKey<FormState>();
  late RxBool isLoading = false.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController relationshipController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  NetworkHandler networkHandler = NetworkHandler();
  final List<String?> errors = [];
  XFile? imageFile;

  ImagePicker picker = ImagePicker();

  void takePhoto(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    print(source);
    if (pickedFile != null) {
      imageFile = XFile(pickedFile.path);
      update();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    relationshipController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  void addError(String? error) {
    if (error != null && !errors.contains(error)) {
      errors.add(error);
      update();
    }
  }

  void removeError(String? error) {
    if (error != null && errors.contains(error)) {
      errors.remove(error);
      update();
    }
  }

  String? validatephoneNumber(String? value) {
    if (!RegExp(r'^\d{8}$').hasMatch(value!)) {
      addError("kPhoneNumberValidation".tr);
      return '';
    } else {
      removeError("kPhoneNumberNullError".tr);
      removeError("kPhoneNumberValidation".tr);
    }
    return null;
  }

  String? onChangedphonenumber(String? value) {
    if (RegExp(r'^\d{8}$').hasMatch(value!)) {
      removeError("kPhoneNumberValidation".tr);
    }
    return null;
  }

  String? onChangedname(String? value) {
    if (value!.isNotEmpty) {
      removeError("kNamelNullError".tr);
    } else if (RegExp(r'^[a-zA-Z\s.,!?]+$').hasMatch(value)) {
      removeError("kNamevalidationError".tr);
    }
    return null;
  }

  String? validateName(String? value) {
    if (value!.isEmpty) {
      addError("kNamelNullError".tr);
      return '';
    } else if (!RegExp(r'^[a-zA-Z\s.,!?]+$').hasMatch(value)) {
      addError("kNamevalidationError".tr);
      return '';
    } else {
      removeError("kNamelNullError".tr);
      removeError("kNamevalidationError".tr);
    }
    return null;
  }

  String? onChangedrelation(String? value) {
    if (value!.isNotEmpty) {
      removeError("this field is required");
    } else if (RegExp(r'^[a-zA-Z\s.,!?]+$').hasMatch(value)) {
      removeError("kNamevalidationError".tr);
    }
    return null;
  }

  String? validateRelation(String? value) {
    if (value!.isEmpty) {
      addError("this field is required");
      return '';
    } else if (!RegExp(r'^[a-zA-Z\s.,!?]+$').hasMatch(value)) {
      addError("kNamevalidationError".tr);
      return '';
    } else {
      removeError("this field is required");
      removeError("kNamevalidationError".tr);
    }
    return null;
  }

  Future<void> addEmergencyContact() async {
    isLoading.value = true;
    try {
      if (formKeyEmCo.currentState!.validate()) {
        Map<String, String> data = {
          'name': nameController.text,
          'phoneNumber': phoneNumberController.text,
          'relationship': relationshipController.text,
        };
        final response =
            await networkHandler.post("$patientUri/emergency-contacts", data);
        final responseData = json.decode(response.body);
        if (response.statusCode == 200 || response.statusCode == 201) {
          final id = responseData['_id'];
          if (imageFile != null && imageFile!.path.isNotEmpty) {
            final imageResponse = await networkHandler.patchImage(
                "$fileUri/emergency-contact/$id", imageFile!.path);

            if (imageResponse.statusCode == 200) {
              Get.snackbar(
                  "Emergency Contact Added", "you can add another one ");
              nameController.clear();
              phoneNumberController.clear();
              relationshipController.clear();
            } else {
              print("imageResponse statusCode : ${imageResponse.statusCode}");
            }
          } else {
            Get.snackbar("Emergency Contact Added", "you can add another one ");
            nameController.clear();
            phoneNumberController.clear();
            relationshipController.clear();
          }
        } else if (response.statusCode == 500) {
          final errors = responseData['message'];
          addError(errors);
        }
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> next() async {
    isLoading.value = true;
    if (nameController.text.isNotEmpty &&
        phoneNumberController.text.isNotEmpty &&
        relationshipController.text.isNotEmpty) {
      try {
        if (formKeyEmCo.currentState!.validate()) {
          Map<String, String> data = {
            'name': nameController.text,
            'phoneNumber': phoneNumberController.text,
            'relationship': relationshipController.text,
          };

          final response =
              await networkHandler.post("$patientUri/emergency-contacts", data);
          final responseData = json.decode(response.body);
          if (response.statusCode == 200 || response.statusCode == 201) {
            final id = responseData['_id'];
            if (imageFile != null && imageFile!.path.isNotEmpty) {
              final imageResponse = await networkHandler.patchImage(
                  "$fileUri/emergency-contact/$id", imageFile!.path);

              if (imageResponse.statusCode == 200) {
                nameController.clear();
                phoneNumberController.clear();
                relationshipController.clear();
                Get.offAll(() => HomeScreen());
              } else {
                print("imageResponse statusCode : ${imageResponse.statusCode}");
              }
            } else {
              nameController.clear();
              phoneNumberController.clear();
              relationshipController.clear();
              Get.offAll(() => HomeScreen());
            }
          } else if (response.statusCode == 500) {
            final errors = responseData['message'];
            addError(errors);
          }
        }
      } catch (e) {
        print(e);
      } finally {
        isLoading.value = false;
      }
    } else {
      isLoading.value = false;
      Get.offAll(() => HomeScreen());
    }
  }
}
