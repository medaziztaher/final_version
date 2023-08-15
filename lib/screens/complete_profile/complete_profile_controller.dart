import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medilink_app/api/global.dart';
import 'package:medilink_app/api/loged_in_user_details.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/models/options.dart';
import 'package:medilink_app/screens/authentification/signin/signin_screen.dart';
import 'package:medilink_app/screens/emergency_contact/add_emergency_conatct/add_emergency_contact_screen.dart';
import 'package:medilink_app/settings/networkhandler.dart';
import 'package:medilink_app/settings/shared_prefs.dart';

class CompleteProfileController extends GetxController {
  GlobalKey<FormState> formKeyCompleteProfile = GlobalKey<FormState>();
  TextEditingController adressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateofbirthController = TextEditingController();
  TextEditingController nembredenfantController = TextEditingController();
  TextEditingController veriffiactionControler = TextEditingController();
  TextEditingController occupationController = TextEditingController();

  Rx<String> selectedDate = ''.obs;
  late RxBool isLoading = false.obs;
  final pref = Pref();
  final List<String?> errors = [];
  late String gender = 'Male';
  late String etatcivil = 'Single';
  late String specialite = "";
  late String? type;
  final errorMessage = ''.obs;
  NetworkHandler networkHandler = NetworkHandler();
  XFile? imageFile;
  ImagePicker picker = ImagePicker();
  List<Options>? specialites = [];
  List<XFile?> imageFiles = List<XFile?>.filled(4, null);
  late String? globalRole;

  @override
  void onInit() {
    _initialize();
    super.onInit();
  }

  void _initialize() async {
    type = await getUserType();
    globalRole = await getUserRole();
    update();
  }

  @override
  void dispose() {
    adressController.dispose();
    phoneNumberController.dispose();
    descriptionController.dispose();
    dateofbirthController.dispose();
    nembredenfantController.dispose();
    veriffiactionControler.dispose();
    occupationController.dispose();
    super.dispose();
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    print(source);
    if (pickedFile != null) {
      imageFile = XFile(pickedFile.path);
      update();
    }
  }

  Future<void> getAllSpeciality() async {
    try {
      final response = await networkHandler.get("$optionUri/speciality");
      print(response);
      final data = json.decode(response.body)['data'] as List<dynamic>;
      final newSpecialities =
          data.map((item) => Options.fromJson(item)).toList(growable: false);
      specialites = newSpecialities;
      update();
    } catch (e) {
      print(e);
    }
  }

  Future<void> completeProfile() async {
    isLoading.value = true;
    removeError("kerror1".tr);
    removeError("kerror2".tr);
    try {
      if (formKeyCompleteProfile.currentState!.validate()) {
        Map<String, String> data = {
          'address': adressController.text,
          'phoneNumber': phoneNumberController.text,
          'gender': gender,
          'dateOfBirth': dateofbirthController.text,
          'civilState': etatcivil,
          'numberOfChildren': nembredenfantController.text,
          'occupation': occupationController.text,
          'description': descriptionController.text,
          'speciality': specialite,
          'licenseVerificationCode': veriffiactionControler.text,
        };
        final response =
            await networkHandler.put("$userUri/complete-profile", data);
        print(response.statusCode);
        print(response.body);
        if (response.statusCode == 200 || response.statusCode == 201) {
          if (imageFile != null &&
              imageFile!.path.isNotEmpty &&
              (globalRole == 'Patient' || type == 'Doctor')) {
            print("path : ${imageFile!.path}");
            final imageResponse = await networkHandler.patchImage(
                "$fileUri/profile-picture", imageFile!.path);
            if (imageResponse.statusCode == 200) {
              String? type;
              type = await queryHealthcareProvdierType();
              if (type == 'Doctor') {
                Get.offAll(() => const SignInScreen());
                Get.snackbar("Admin Verification",
                    "Please wait until our admin approuve your account");
              } else {
                Get.offAll(() => const AddEmergencyContact());
              }
            } else {
              print(" image path status code : ${imageResponse.statusCode}");
            }
          } else if (globalRole == 'HealthcareProvider' &&
              type != 'Doctor') {
            for (int i = 0; i < imageFiles.length; i++) {
              print(imageFiles);
              XFile? imageFile = imageFiles[i];
              if (imageFile != null && imageFile.path.isNotEmpty) {
                print(imageFile.path);
                final imageResponse = await networkHandler.patchImage(
                    buildingpicsPath, imageFile.path);
                if (imageResponse.statusCode == 200) {
                  Get.offAll(() => const SignInScreen());
                  Get.snackbar("Admin Verification",
                      "Please wait until our admin approuve your account");
                }
                print(
                    " image building path status code : ${imageResponse.statusCode}");
              }
            }
          }
        } else {
          final message = json.decode(response.body)['message'];
          addError(message);
        }
      }
    } on SocketException {
      addError("kerror1".tr);
    } catch (e) {
      addError("kerror2".tr);
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void selectImage(int imageIndex) async {
    try {
      final picker = ImagePicker();
      XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        imageFiles[imageIndex - 1] = pickedFile;
        update();
      }
    } catch (e) {
      print('Error selecting image: $e');
    }
  }

  void takebuildingPhoto(ImageSource source, int imageIndex) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      imageFiles[imageIndex - 1] = XFile(pickedFile.path);
      update();
    }
  }

  void deleteImage(int imageIndex) {
    imageFiles[imageIndex - 1] = null;
    update();
  }

  String? validatebirthdate(String? value) {
    if (!RegExp(r'^\d{2}[/-]\d{2}[/-]\d{4}$').hasMatch(value!)) {
      addError("kbirthdateValidation".tr);
      return '';
    } else {
      removeError("kbirthdateValidation".tr);

      try {
        List<int> dateParts;
        if (value.contains('/')) {
          dateParts = value.split('/').map(int.parse).toList();
        } else {
          dateParts = value.split('-').map(int.parse).toList();
        }

        final day = dateParts[0];
        final month = dateParts[1];
        final year = dateParts[2];

        final birthdate = DateTime(year, month, day);

        final now = DateTime.now();

        if (birthdate.isAfter(now)) {
          addError("kbirthdateValidation".tr);
          return '';
        }
      } catch (e) {
        addError("kbirthdateValidation".tr);
        return '';
      }
    }

    return null;
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

  String? validatesInstituation(String? value) {
    if (value!.isEmpty) {
      addError("kNamelNullError".tr);
      return '';
    } else if (!RegExp(r'^[a-zA-Z\s.,!?]+$').hasMatch(value)) {
      addError("kNamevalidationError".tr);
      return '';
    } else {
      removeError("kNamevalidationError".tr);
    }
    return null;
  }

  String? validatesDegree(String? value) {
    if (!RegExp(r'^[a-zA-Z\s.,!?]+$').hasMatch(value!)) {
      addError("kNamevalidationError".tr);
      return '';
    } else {
      removeError("kNamevalidationError".tr);
    }
    return null;
  }

  String? validatedescription(String? value) {
    if ((value?.split('\n').length)! > 3) {
      addError("kdescriptionvalidation".tr);
      return '';
    } else {
      removeError("kdescriptionvalidation".tr);
    }
    return null;
  }

  String? validateGender(String? value) {
    if (value!.isEmpty) {
      addError("kGenderNullError".tr);
      return '';
    } else {
      removeError("kGenderNullError".tr);
    }
    return null;
  }

  String? onChangedbirthdate(String? value) {
    if (RegExp(r'^\d{1,2}/\d{1,2}/\d{4}$').hasMatch(value!)) {
      removeError("kbirthdateValidation".tr);
    }
    return null;
  }

  void onChangedGender(String? value) {
    if (value!.isNotEmpty) {
      removeError("kGenderNullError".tr);
    }
    gender = value;
    update();
  }

  String? onChangedphonenumber(String? value) {
    if (RegExp(r'^\d{8}$').hasMatch(value!)) {
      removeError("kPhoneNumberValidation".tr);
    }
    return null;
  }

  String? onChangedspecialization(String? value) {
    if (RegExp(r'^[a-zA-Z\s.,!?]+$').hasMatch(value!)) {
      removeError("kNamevalidationError".tr);
    }
    return null;
  }

  String? onChangeddescription(String? value) {
    if (value!.length < 3) {
      removeError("kdescriptionvalidation".tr);
    }
    return null;
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

  void onChangedetatcivil(String? value) {
    if (value!.isNotEmpty) {
      removeError("kTypeNullError".tr);
    }
    etatcivil = value;
    update();
  }

  void onChangeSpecialite(String? value) {
    if (value!.isNotEmpty) {
      removeError("kTypeNullError".tr);
    }
    specialite = value;
    update();
  }

  String? validatespecialization(String? value) {
    if (value!.isEmpty) {
      addError("kNamelNullError".tr);
      return '';
    } else if (!RegExp(r'^[a-zA-Z\s.,!?]+$').hasMatch(value)) {
      addError("kNamevalidationError".tr);
      return '';
    } else {
      removeError("kNamevalidationError".tr);
    }
    return null;
  }
}
