import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/screens/authentification/forget_password/otp/otp.dart';
import 'package:medilink_app/settings/networkhandler.dart';
import 'package:medilink_app/utils/constants.dart';

class ForgetPassEmail extends GetxController {
  GlobalKey<FormState> formKeySignIn = GlobalKey<FormState>();
  final emailController = TextEditingController();
  late RxBool isLoading = false.obs;
  NetworkHandler networkHandler = NetworkHandler();
  final List<String?> errors = [];

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

  String? onChangedEmail(String? value) {
    if (value!.isNotEmpty) {
      removeError("kEmailNullError".tr);
    } else if (emailValidatorRegExp.hasMatch(value)) {
      removeError("kInvalidEmailError".tr);
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

  Future<void> onSubmit() async {
    isLoading.value = true;
    Map<String, String> data = {
      'email': emailController.text,
    };
    try {
      var response = await networkHandler.post('$authUri/forgetPassword', data);
      print(response.body);
      var responseData = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.off(() => OTPScreen(email: emailController.text));
      } else {
        final message = responseData['error'];
        addError(message);
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
