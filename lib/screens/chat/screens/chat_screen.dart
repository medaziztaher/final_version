import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilink_app/api/global.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/models/message.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/navigation/patient/patient_navigation_controller.dart';
import 'package:medilink_app/settings/networkhandler.dart';
import 'package:medilink_app/settings/realtime.dart';
import 'package:medilink_app/settings/realtimelogic.dart';
import 'package:medilink_app/utils/constants.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.convId,
  });
  final String convId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  PatientNavigationController patientNavigationController =
      Get.put(PatientNavigationController());
  bool isLoading = false;
  List<ChatMessage> messages = [];
  final socket = SocketClient.instance.socket!;
  NetworkHandler networkHandler = NetworkHandler();
  final SocketMethods _socket = SocketMethods();
  final TextEditingController _textEditingController = TextEditingController();
  String? receiverId;
  String? senderId;
  User? receiver;
  String? relation;
  @override
  void initState() {
    super.initState();
    _socket.connectUser();
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    receiverId = widget.convId;
    senderId = await getUserId();
    await getreceiverData();
    await fetchMessages();
    _setupSocketListeners();
    await _checkUser();
  }

  Future<void> getreceiverData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await networkHandler.get("$userUri/${widget.convId}");
      if (json.decode(response.body)['status'] == true) {
        setState(() {
          receiver = User.fromJson(json.decode(response.body)['data']);
        });
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
    }
  }

  Future<void> fetchMessages() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response =
          await networkHandler.get("$messageUri/${widget.convId}/messagesUser");

      print("fetched Data: $response");
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("data: ${json.decode(response.body)['data']}");
        final data = json.decode(response.body)['data'] as List<dynamic>;
        setState(() {
          messages = data.map((json) => ChatMessage.fromJson(json)).toList();
        });
      } else if (json.decode(response.body)['status'] == false) {
        return;
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _setupSocketListeners() {
    socket.on('getMessage', (data) {
      if (mounted) {
        setState(() {
          final messageData = data['data'];
          final newMessage = ChatMessage.fromJson(messageData);
          messages.add(newMessage);
        });
      }
    });
    socket.on('unfollowSuccess', (data) {
      if (mounted) {
        _checkUser();
      }
    });
    socket.on('followRequestApproved', (data) {
      if (mounted) {
        _checkUser();
      }
    });
  }

  void sendMessage(String message) async {
    setState(() {
      messages.add(ChatMessage(
          content: message, receiver: receiverId!, sender: senderId!));
    });

    await _socket.sendMessage(senderId!, receiverId!, message);

    _textEditingController.clear();
  }

  Future<void> _checkUser() async {
    final response =
        await networkHandler.get("$userUri/ckeck-user/${widget.convId}");
    final responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        relation = responseData['message'];
      });
    } else {
      setState(() {
        relation = responseData['message'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: defaultScreenPadding,
            right: defaultScreenPadding,
            left: defaultScreenPadding,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const ImageIcon(
                          AssetImage("assets/icons/back.png"),
                          color: typingColor,
                          size: 26,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.grey[50],
                        backgroundImage: receiver?.picture != null
                            ? CachedNetworkImageProvider(receiver!.picture!)
                            : const AssetImage(kProfile) as ImageProvider,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            receiver?.name ?? "",
                            style: GoogleFonts.nunitoSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: typingColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "Online",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: ImageIcon(
                          const AssetImage(
                            "assets/icons/facetime-button.png",
                          ),
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(0.3),
                          size: 22,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      InkWell(
                        onTap: () {},
                        child: ImageIcon(
                          const AssetImage(
                            "assets/icons/phone-call.png",
                          ),
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(0.3),
                          size: 22,
                        ),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 26,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  reverse: true,
                  itemBuilder: (context, index) {
                    final reversedIndex = messages.length - 1 - index;
                    final message = messages[reversedIndex];
                    final isSenderMessage = message.sender == senderId;

                    return ListTile(
                      title: Align(
                        alignment: isSenderMessage
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isSenderMessage
                                ? Colors.blue
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            message.content,
                            style: TextStyle(
                              color:
                                  isSenderMessage ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SafeArea(
                child: relation == 'followed'
                    ? Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blueGrey[50],
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(22),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: TextField(
                                      controller: _textEditingController,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 16,
                                        ),
                                        hintText: "Type your message",
                                        hintStyle: GoogleFonts.nunitoSans(
                                            fontSize: 16,
                                            color:
                                                typingColor.withOpacity(0.75),
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      ImageIcon(
                                        const AssetImage(
                                          "assets/icons/attach-paperclip-symbol.png",
                                        ),
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .color!
                                            .withOpacity(0.3),
                                        size: 20,
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      ImageIcon(
                                        const AssetImage(
                                          "assets/icons/microphone.png",
                                        ),
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .color!
                                            .withOpacity(0.3),
                                        size: 20,
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                final message = _textEditingController.text;
                                sendMessage(message);
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(16),
                                child: const ImageIcon(
                                  AssetImage("assets/icons/send.png"),
                                  color: Colors.white,
                                  size: 22,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    : const Center(
                        child: Text(
                          "You can't send a message to this account anymore.",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
