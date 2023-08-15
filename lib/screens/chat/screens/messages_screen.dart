import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilink_app/components/custom_search_bar.dart';
import 'package:medilink_app/navigation/patient/patient_navigation_controller.dart';
import 'package:medilink_app/screens/chat/screens/chat_screen.dart';
import 'package:medilink_app/screens/chat/screens/messages_controller.dart';
import 'package:medilink_app/screens/chat/widgets/chat_card.dart';
import 'package:medilink_app/screens/notification/notification_screen.dart';
import 'package:medilink_app/utils/constants.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PatientNavigationController patientNavigationController =
        Get.put(PatientNavigationController());
    final userConversationsController = Get.put(MessagesController());
    userConversationsController.getConversations();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: const ImageIcon(
          AssetImage("assets/icons/edit.png"),
          size: 28,
          color: Colors.white,
        ),
        onPressed: () {
          patientNavigationController.updateCurrentChatPage(1);
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            right: defaultScreenPadding,
            left: defaultScreenPadding,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: defaultScreenPadding,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Messages",
                      style: GoogleFonts.nunitoSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: typingColor),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(const NotificationScreen());
                      },
                      child: Container(
                        width: 42,
                        height: 42,
                        padding: const EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(84, 228, 226, 226),
                              blurRadius: 15.0, // soften the shadow
                              spreadRadius: 3.0, //extend the shadow
                            )
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(14),
                          ),
                        ),
                        child: const ImageIcon(
                          AssetImage("assets/icons/bell-ring.png"),
                          color: typingColor,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 26,
                ),
                const CustomSearchBar(
                  searchText: "Search Messages",
                  withFilteringBadge: true,
                ),
                const SizedBox(
                  height: 26,
                ),
                SizedBox(child: Obx(() {
                  if (userConversationsController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (userConversationsController
                      .conversations.isNotEmpty) {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            userConversationsController.conversations.length,
                        itemBuilder: (context, index) {
                          final conversation =
                              userConversationsController.conversations[index];
                          return ChatCard(
                            chat: conversation,
                            onTap: () => {
                              Get.to(ChatScreen(
                                convId: conversation.id,
                              )),
                            },
                          );
                        });
                  } else {
                    return const Center(
                        child: Text("you don't have any conversation"));
                  }
                })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
