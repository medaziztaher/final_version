import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink_app/api/loged_in_user_details.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/screens/complete_profile/complete_profile.dart';
import 'package:medilink_app/settings/networkhandler.dart';
import 'package:medilink_app/settings/shared_prefs.dart';
import 'package:medilink_app/utils/constants.dart';

class SignupController extends GetxController {
  GlobalKey<FormState> formKeySignUp = GlobalKey<FormState>();
  NetworkHandler networkHandler = NetworkHandler();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController nameController;
  late TextEditingController firstnameController;
  late TextEditingController lastnameController;
  late RxBool isLoading = false.obs;
  final pref = Pref();
  final List<String?> errors = [];
  late String role = '';
  late String type = 'Doctor';
  late String confirmpassword;
  final errorMessage = ''.obs;

  @override
  void onClose() {
    emailController.dispose();
    firstnameController.dispose();
    lastnameController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    emailController = TextEditingController();
    firstnameController = TextEditingController();
    lastnameController = TextEditingController();
    nameController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      addError("kEmailNullError".tr);
      return '';
    } else if (!emailValidatorRegExp.hasMatch(value)) {
      addError("kInvalidEmailError".tr);
      return '';
    } else {
      removeError("kEmailNullError".tr);
      removeError("kInvalidEmailError".tr);
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      addError("kPassNullError".tr);
      return '';
    } else if (value.length < 8) {
      addError("kShortPassError".tr);
      return '';
    } else {
      removeError("kPassNullError".tr);
      removeError("kShortPassError".tr);
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

  String? validateFirstName(String? value) {
    if (value!.isEmpty) {
      addError("kFirstNamelNullError".tr);
      return '';
    } else if (!RegExp(r'^[a-zA-Z\s.,!?]+$').hasMatch(value)) {
      addError("kNamevalidationError".tr);
      return '';
    } else {
      removeError("kFirstNamelNullError".tr);
      removeError("kNamevalidationError".tr);
    }
    return null;
  }

  String? validateLastName(String? value) {
    if (value!.isEmpty) {
      addError("kLastNamelNullError".tr);
      return '';
    } else if (!RegExp(r'^[a-zA-Z\s.,!?]+$').hasMatch(value)) {
      addError("kNamevalidationError".tr);
      return '';
    } else {
      removeError("kLastNamelNullError".tr);
      removeError("kNamevalidationError".tr);
    }
    return null;
  }

  String? validateType(String? value) {
    if (value!.isEmpty) {
      addError("kTypeNullError".tr);
      return '';
    } else {
      removeError("kTypeNullError".tr);
    }
    return null;
  }

  String? validateconfirmPassword(String? value) {
    if (value!.isEmpty) {
      addError("kconfirmPassNullError".tr);
      return '';
    } else if (confirmpassword != passwordController.text) {
      addError("kMatchPassError".tr);
      return '';
    } else {
      removeError("kconfirmPassNullError".tr);
      removeError("kMatchPassError".tr);
    }
    return null;
  }

  String? validateRole(String? value) {
    if (value!.isEmpty) {
      addError("kRoleNullError".tr);
      return '';
    } else {
      removeError("kRoleNullError".tr);
    }
    return null;
  }

  String? onChangedEmail(String? value) {
    if (value!.isNotEmpty) {
      removeError("kEmailNullError".tr);
    } else if (emailValidatorRegExp.hasMatch(value)) {
      removeError("kInvalidEmailError".tr);
    }
    return null;
  }

  String? onChangedPassword(String? value) {
    if (value!.isNotEmpty) {
      removeError("kPassNullError".tr);
    } else if (value.length >= 8) {
      removeError("kShortPassError".tr);
    }
    return null;
  }

  void onChangedRole(String? value) {
    if (value!.isNotEmpty) {
      removeError("kRoleNullError".tr);
    }
    role = value;
    update();
  }

  String? onChangedname(String? value) {
    if (value!.isNotEmpty) {
      removeError("kNamelNullError".tr);
    } else if (RegExp(r'^[a-zA-Z\s.,!?]+$').hasMatch(value)) {
      removeError("kNamevalidationError".tr);
    }
    return null;
  }

  String? onChangedfirstname(String? value) {
    if (value!.isNotEmpty) {
      removeError("kFirstNamelNullError".tr);
    } else if (RegExp(r'^[a-zA-Z\s.,!?]+$').hasMatch(value)) {
      removeError("kNamevalidationError".tr);
    }
    return null;
  }

  String? onChangedlastname(String? value) {
    if (value!.isNotEmpty) {
      removeError("kLastNamelNullError".tr);
    } else if (RegExp(r'^[a-zA-Z\s.,!?]+$').hasMatch(value)) {
      removeError("kNamevalidationError".tr);
    }
    return null;
  }

  void onChangedType(String? value) {
    if (value!.isNotEmpty) {
      removeError("kTypeNullError".tr);
    }
    type = value;
    update();
  }

  void onChangedConfirmPassword(String? value) {
    if (value!.isNotEmpty) {
      removeError("kconfirmPassNullError".tr);
    } else if (value.isNotEmpty && confirmpassword == passwordController.text) {
      removeError("kMatchPassError".tr);
    }
    confirmpassword = value;
    update();
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

  Future<void> submitForm() async {
    isLoading.value = true;
    String? message = "";
    removeError("kerror1".tr);
    removeError("kerror2".tr);
    if (message.isNotEmpty) {
      removeError(message);
    }

    try {
      if (formKeySignUp.currentState!.validate()) {
        Map<String, String> data = {
          'email': emailController.text,
          'password': passwordController.text,
          'role': role,
        };

        if (role == 'Patient') {
          data['firstname'] = firstnameController.text;
          data['lastname'] = lastnameController.text;
        } else if (role == 'HealthcareProvider') {
          if (type == 'Doctor') {
            data['firstname'] = firstnameController.text;
            data['lastname'] = lastnameController.text;
            data['type'] = type;
          } else {
            data['name'] = nameController.text;
            data['type'] = type;
          }
        }
        final response = await networkHandler.post(registerUri, data);
        if (response.statusCode == 201 || response.statusCode == 200) {
          final responseData = json.decode(response.body);
          final token = responseData['token'];
          pref.prefs!.setString(kTokenSave, token);
          await pushDeviceToken();
          Get.off(()=>const CompleteProfileScreen());
          //Get.to(() => MailVerfication());
        } else if (response.statusCode == 401) {
          final responseData = json.decode(response.body);
          final errors = responseData['message'];
          addError(errors);
        } else if (response.statusCode == 500) {
          final responseData = json.decode(response.body);
          final errors = responseData['message'];
          addError(errors);
        }
      }
    } on SocketException {
      addError("kerror1".tr);
    } catch (e) {
      print(e);
      // addError("kerror2".tr);
    } finally {
      isLoading.value = false;
    }
  }
}
