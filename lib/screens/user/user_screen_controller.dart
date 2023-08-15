import 'dart:convert';
import 'package:get/get.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/settings/networkhandler.dart';

class UserData extends GetxController {
  String userId;

  late User user;
  RxBool isLoading = false.obs;
  RxString errorMessage = 'No Error'.obs;

  NetworkHandler networkHandler = NetworkHandler();

  UserData({required this.userId}) {
    getUserData();
  }

  @override
  void onInit() {
    super.onInit();
    getUserData();
  }

  Future<void> getUserData() async {
    isLoading.value = true;
    try {
      final response = await networkHandler.get("$userUri/$userId");
      if (json.decode(response.body)['status'] == true) {
        user = User.fromJson(json.decode(response.body)['data']);
      } else {
        final data = json.decode(json.decode(response.body)['status']);
        errorMessage.value = data;
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
