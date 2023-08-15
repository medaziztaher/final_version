import 'dart:convert';

import 'package:get/get.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/settings/networkhandler.dart';

class UsersSearchController extends GetxController {
  NetworkHandler networkHandler = NetworkHandler();
  final _query = ''.obs;
  String get query => _query.value;
  set query(String value) => _query.value = value;
  RxList<User> searchResults = RxList<User>([]);
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    ever(_query, (_) => searchUsers());
  }

  void clearSearchResults() {
    searchResults.clear();
  }

  Future<void> searchUsers() async {
    isLoading.value = true;
    errorMessage.value = '';

    Map<String, dynamic> requestData = {
      'search': query,
    };

    try {
      final response =
          await networkHandler.post("$userUri/search", requestData);
      print("Server Response :${response.body}");
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print("Response Data: $responseData");

        final data = responseData['date'] as List<dynamic>;
        final user =
            data.map((item) => User.fromJson(item)).toList(growable: false);
        print("User List: $user");
        searchResults.value = user;
      } else {
        final responseData = json.decode(response.body);
        final message = responseData['message'];
        errorMessage.value = message;
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      errorMessage.value = 'Error: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }
}
