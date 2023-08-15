import 'dart:convert';

import 'package:get/get.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/models/surgery.dart';
import 'package:medilink_app/settings/networkhandler.dart';

class UserSurgerieController extends GetxController {
  final RxList<Surgery> surgeries = <Surgery>[].obs;
  String userId;
  RxBool isLoading = false.obs;
  NetworkHandler networkHandler = NetworkHandler();
  UserSurgerieController({required this.userId}) {
    _init();
  }
  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() async {
    await getUserSurgerie();
  }

  Future<void> getUserSurgerie() async {
    isLoading.value = true;
    try {
      final response =
          await networkHandler.get("$patientUri/$userId/surgeries");
      if (json.decode(response.body)['status'] == true) {
        final data = json.decode(response.body)['data'] as List<dynamic>;
        final surgerie =
            data.map((item) => Surgery.fromJson(item)).toList(growable: false);
        surgeries.value = surgerie;
        //update();
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
