import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:medilink_app/api/global.dart';
import 'package:medilink_app/api/loged_in_user_details.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/screens/user/button_section.dart';
import 'package:medilink_app/settings/networkhandler.dart';
import 'package:medilink_app/settings/realtime.dart';
import 'package:medilink_app/settings/realtimelogic.dart';
import 'package:medilink_app/utils/constants.dart';

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key, required this.user});
  final User user;

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  NetworkHandler networkHandler = NetworkHandler();
  String? userId;
  String? message;
  final SocketMethods _socket = SocketMethods();
  final socket = SocketClient.instance.socket!;
  String? logedinuserole;

  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    logedinuserole = await getUserRole();
    _checkUser();
    _socket.connectUser();
    _setupSocketListeners();
  }

  void _setupSocketListeners() {
    socket.on('followRequestError', (data) {
      if (mounted) {}
    });
    socket.on('followRequest', (data) {
      if (mounted) {
        _checkUser();
      }
    });
    socket.on('followRequestReceived', (data) {
      if (mounted) {
        _checkUser();
      }
    });
    socket.on('followRequestApproved', (data) {
      if (mounted) {
        _checkUser();
      }
    });
    socket.on('followRequestdeclined', (data) {
      if (mounted) {
        _checkUser();
      }
    });
    socket.on('declineRequestError', (data) {
      if (mounted) {
        _checkUser();
      }
    });
    socket.on('approveRequestError', (data) {
      if (mounted) {
        _checkUser();
      }
    });
    socket.on('unfollowSuccess', (data) {
      if (mounted) {
        _checkUser();
      }
    });
    socket.on('cancelRequestSuccess', (data) {
      if (mounted) {
        _checkUser();
      }
    });
  }

  Future<void> _checkUser() async {
    final response =
        await networkHandler.get("$userUri/ckeck-user/${widget.user.id}");
    final responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        message = responseData['message'];
      });
    } else {
      setState(() {
        message = responseData['message'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Stack(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: widget.user.picture != null
                            ? CachedNetworkImageProvider(widget.user.picture!)
                            : const AssetImage(kProfile) as ImageProvider,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Dr. ${widget.user.name}",
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.user.speciality ?? "",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      if (logedinuserole == "Patient") ...[
                        ButtonSection(
                          phoneNumber: widget.user.phoneNumber!,
                          userId: widget.user.id,
                          message: message,
                          onFollow: () async {
                            String? senderId = await queryUserID();
                            print('Follow clicked. SenderId: $senderId');
                            _socket.followUser(senderId!, widget.user.id);
                          },
                          onUnfollow: () async {
                            String? senderId = await queryUserID();
                            print('Unfollow clicked. SenderId: $senderId');
                            _socket.unfollowUser(senderId!, widget.user.id);
                          },
                          onCancelRequest: () async {
                            String? senderId = await queryUserID();
                            print(
                                'Cancel request clicked. SenderId: $senderId');
                            _socket.cancelRequest(senderId!, widget.user.id);
                          },
                          onApprove: () async {
                            String? senderId = await queryUserID();
                            print('Approve clicked. SenderId: $senderId');
                            _socket.approveRequest(senderId!, widget.user.id);
                          },
                          onDecline: () async {
                            String? senderId = await queryUserID();
                            print('decline clicked. SenderId: $senderId');
                            _socket.declineRequest(senderId!, widget.user.id);
                          },
                        )
                      ]
                    ],
                  ),
                ),
              ]),
            ),
            const SizedBox(height: 20),
            Container(
              height: MediaQuery.of(context).size.height / 1.5,
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 20,
                left: 15,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      widget.user.description ?? "",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          "Reviews",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Icon(Icons.star, color: Colors.amber),
                        const Text(
                          "4.9",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          "(124)",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.blue,
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "see all",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 160,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                const BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 1.4,
                              child: const Column(
                                children: [
                                  ListTile(
                                    leading: CircleAvatar(
                                      radius: 25,
                                      backgroundImage: AssetImage(kProfile),
                                    ),
                                    title: Text(
                                      "Dr.Doctor Name",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text("1 day ago"),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        Text(
                                          "4.9",
                                          style: TextStyle(
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      "Many thanks to Dr. Dear .he is a great ",
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Location",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Color(0xFFF0EEFA),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.blue,
                          size: 30,
                        ),
                      ),
                      title: Text(
                        widget.user.address ?? "",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: const Text(
                        "adress line of the medical center",
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(15),
                      height: 130,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
