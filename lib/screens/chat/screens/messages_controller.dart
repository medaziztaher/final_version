import 'dart:convert';
import 'package:get/get.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/models/conversation.dart';
import 'package:medilink_app/settings/networkhandler.dart';


class MessagesController extends GetxController {
  RxBool isLoading = false.obs;
  final RxList<ConversationDetails> conversations = <ConversationDetails>[].obs;
  NetworkHandler networkHandler = NetworkHandler();

  @override
  void onInit() {
    super.onInit();
    getConversations();
  }

  Future<void> getConversations() async {
    isLoading.value = true;
    try {
      final response = await networkHandler.get("$conversationUri/");
      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        final data = responseData['data'] as List<dynamic>;
        final conversation = data
            .map((item) => ConversationDetails.fromJson(item))
            .toList(growable: false);
        conversations.value = conversation;
      } else {
        final message = responseData['message'];
        Get.snackbar("${response.statusCode}", message);
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
