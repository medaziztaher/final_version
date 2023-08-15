import 'dart:convert';
import 'package:get/get.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/models/allergy.dart';
import 'package:medilink_app/settings/networkhandler.dart';

class UserAllergeyController extends GetxController {
  final RxList<Allergy> allergies = <Allergy>[].obs;
  String userId;
  RxBool isLoading = false.obs;
  NetworkHandler networkHandler = NetworkHandler();
  UserAllergeyController({required this.userId}) {
    _init();
  }
  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() async {
    await getUserAllergy();
  }

  Future<void> getUserAllergy() async {
    isLoading.value = true;
    try {
      final response =
          await networkHandler.get("$patientUri/$userId/allergies");
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'] as List<dynamic>;
        final allergy =
            data.map((item) => Allergy.fromJson(item)).toList(growable: false);
        allergies.value = allergy;
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
