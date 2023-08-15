import 'dart:convert';
import 'package:get/get.dart';
import 'package:medilink_app/api/global.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/models/surgery.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/settings/networkhandler.dart';

class GetSurgerieController extends GetxController {
  String surgerieId;
  RxString userId = "".obs;
  Surgery surgerie = Surgery(
      date: DateTime.now(), description: '', id: '', patient: '', type: '');

  RxBool isLoading = false.obs;
  NetworkHandler networkHandler = NetworkHandler();
  RxString provider = "".obs;

  GetSurgerieController({required this.surgerieId}) {
    _init();
  }
  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() async {
    String? userId = await getUserId();
    this.userId.value = userId!;
    await getsurgerie();
    await getProvider();
  }

  Future<void> getProvider() async {
    try {
      final response =
          await networkHandler.get("$userUri/${surgerie.provider}");
      if (json.decode(response.body)['status'] == true) {
        User user = User.fromJson(json.decode(response.body)['data']);
        provider.value = user.name;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getsurgerie() async {
    try {
      final response = await networkHandler.get("$surgerieUri/$surgerieId");

      print(json.decode(response.body)['status']);
      if (json.decode(response.body)['status'] == true) {
        surgerie = Surgery.fromJson(json.decode(response.body)['data']);
        update();
      }
    } catch (e) {
      print(e);
    }
  }
}
