import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink_app/api/loged_in_user_details.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/screens/home/home_screen.dart';
import 'package:medilink_app/settings/networkhandler.dart';
import 'package:medilink_app/settings/shared_prefs.dart';
import 'package:medilink_app/utils/constants.dart';

class SignInController extends GetxController {
  GlobalKey<FormState> formKeySignIn = GlobalKey<FormState>();
  NetworkHandler networkHandler = NetworkHandler();
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late RxBool isLoading = false.obs;
  final isRememberMe = false.obs;
  final passToggle = false.obs;
  final List<String?> errors = [];
  final pref = Pref();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  Future<void> submitForm() async {
    isLoading.value = true;
    String? message = "";
    removeError("kerror1".tr);
    removeError("kerror2".tr);
    if (message.isNotEmpty) {
      removeError(message);
    }
    Map<String, String> data = {
      'email': emailController.text,
      'password': passwordController.text,
    };
    try {
      if (formKeySignIn.currentState!.validate()) {
        final response = await networkHandler.post(loginUri, data);
        final responseData = json.decode(response.body);
        if (response.statusCode == 200 || response.statusCode == 201) {
          final token = responseData['token'];
          pref.prefs!.setString(kTokenSave, token);
          await pushDeviceToken();
          Get.offAll(() => const HomeScreen());
        } else {
          message = responseData['message'];
          addError(message);
          passwordController.clear();
        }
      }
    } on SocketException {
      addError('kerror1'.tr);
    } catch (e) {
      addError('kerror2'.tr);
    } finally {
      isLoading.value = false;
    }
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

  void addError(String? error) {
    if (!errors.contains(error)) {
      errors.add(error);
      update();
    }
  }

  void removeError(String? error) {
    if (errors.contains(error)) {
      errors.remove(error);
      update();
    }
  }

  void togglePasswordVisibility() {
    passToggle.value = !passToggle.value;
    update();
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
}
