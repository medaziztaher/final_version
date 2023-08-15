import 'dart:convert';
import 'package:get/get.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/models/radiographie.dart';
import 'package:medilink_app/settings/networkhandler.dart';


class UserRadioController extends GetxController {
  final RxList<Radiographie> radiographies = <Radiographie>[].obs;
  String userId;
  RxBool isLoading = false.obs;
  NetworkHandler networkHandler = NetworkHandler();
  UserRadioController({required this.userId}) {
    _init();
  }
  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() async {
    await getUserRadiographie();
  }

  Future<void> getUserRadiographie() async {
    isLoading.value = true;
    try {
      final response =
          await networkHandler.get("$patientUri/$userId/radiographies");
      if (json.decode(response.body)['status'] == true) {
        final data = json.decode(response.body)['data'] as List<dynamic>;
        final radio = data
            .map((item) => Radiographie.fromJson(item))
            .toList(growable: false);
        radiographies.value = radio;
        //update();
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
