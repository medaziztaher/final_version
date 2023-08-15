import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink_app/api/global.dart';
import 'package:medilink_app/api/loged_in_user_details.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/screens/user/button_section.dart';
import 'package:medilink_app/settings/networkhandler.dart';
import 'package:medilink_app/settings/realtime.dart';
import 'package:medilink_app/settings/realtimelogic.dart';


class ProviderScreen extends StatefulWidget {
  const ProviderScreen({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<ProviderScreen> createState() => _ProviderScreenState();
}

class _ProviderScreenState extends State<ProviderScreen> {
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
    if (json.decode(response.body)['status'] == true) {
      setState(() {
        message = json.decode(response.body)['message'];
      });
    } else {
      setState(() {
        message = json.decode(response.body)['message'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Stack(children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Container(
                      height: 250,
                      child: widget.user.buildingpictures != null &&
                              widget.user.buildingpictures!.isNotEmpty
                          ? SizedBox(
                              height: 300,
                              width: double.infinity,
                              child: CarouselSlider(
                                options: CarouselOptions(
                                  height: 400,
                                  aspectRatio: 16 / 9,
                                  viewportFraction: 0.8,
                                  initialPage: 0,
                                  enableInfiniteScroll: true,
                                  reverse: false,
                                  autoPlay: true,
                                  autoPlayInterval: const Duration(seconds: 3),
                                  autoPlayAnimationDuration:
                                      const Duration(milliseconds: 800),
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  enlargeCenterPage: true,
                                  enlargeStrategy:
                                      CenterPageEnlargeStrategy.height,
                                  scrollDirection: Axis.horizontal,
                                ),
                                items: widget.user.buildingpictures!
                                    .map((buildingPicture) {
                                  return Builder(
                                      builder: (BuildContext context) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 1.0),
                                      child: CachedNetworkImage(
                                        imageUrl: buildingPicture,
                                        height: 50,
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url, error) =>
                                            const Center(
                                          child: Text('Error loading image.'),
                                        ),
                                        placeholder: (context, url) =>
                                            Container(
                                          color: Colors.grey[300],
                                        ),
                                      ),
                                    );
                                  });
                                }).toList(),
                              ),
                            )
                          : const Center(child: Text("No user data found.")),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "${widget.user.name}",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                      ),
                    ),
                    if (logedinuserole == "Patient") ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                              Get.back();
                            },
                          )
                        ],
                      )
                    ]
                  ],
                ),
              ),
            ]),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    widget.user.description ?? "",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
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
                    ],
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
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: const Text(
                      "address line of the medical center",
                    ),
                  ),
                  SizedBox(height: 20),
                  Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
