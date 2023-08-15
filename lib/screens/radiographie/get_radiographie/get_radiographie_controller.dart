import 'dart:convert';

import 'package:get/get.dart';
import 'package:medilink_app/api/global.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/models/radiographie.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/settings/networkhandler.dart';


class GetRadioController extends GetxController {
  String radioId;
  RxString userId = "".obs;
  Radiographie radiographie = Radiographie(
      date: DateTime.now(), description: '', id: '', patient: '', type: '', reason: '');

  RxBool isLoading = false.obs;
  NetworkHandler networkHandler = NetworkHandler();
  RxString provider = "".obs;

  GetRadioController({required this.radioId}) {
    _init();
  }
  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() async {
    userId.value = (await getUserId())!;
    await getradiographie();
    await getProvider();
  }

  Future<void> getProvider() async {
    try {
      final response =
          await networkHandler.get("$userUri/${radiographie.provider}");
      if (json.decode(response.body)['status'] == true) {
        User user = User.fromJson(json.decode(response.body)['data']);
        provider.value = user.name;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getradiographie() async {
    try {
      final response = await networkHandler.get("$radiographieUri/$radioId");
      print(json.decode(response.body)['status']);
      if (json.decode(response.body)['status'] == true) {
        radiographie =
            Radiographie.fromJson(json.decode(response.body)['data']);
        update();
      }
    } catch (e) {
      print(e);
    }
  }
}
