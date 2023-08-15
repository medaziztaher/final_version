import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medilink_app/api/global.dart';
import 'package:medilink_app/api/loged_in_user_details.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/screens/analyse/add_analyse/add_analyse_screen.dart';
import 'package:medilink_app/screens/dossier_medical/componnets/dossier_medical_menu.dart';
import 'package:medilink_app/screens/dossier_medical/dossier_medicale_screen.dart';
import 'package:medilink_app/screens/radiographie/add_radiographie/add_radiographie_screen.dart';
import 'package:medilink_app/screens/user/button_section.dart';
import 'package:medilink_app/settings/networkhandler.dart';
import 'package:medilink_app/settings/realtime.dart';
import 'package:medilink_app/settings/realtimelogic.dart';
import 'package:medilink_app/utils/constants.dart';

class PatientScreen extends StatefulWidget {
  const PatientScreen({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<PatientScreen> createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
  bool isFollowed = false;
  NetworkHandler networkHandler = NetworkHandler();
  String? message;
  final SocketMethods _socket = SocketMethods();
  final socket = SocketClient.instance.socket!;
  String? type;

  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    type = await getUserType();
    print("type : $type");
    _checkUser();
    _socket.connectUser();
    _setupSocketListeners();
  }

  Future<void> _checkUser() async {
    try {
      final response =
          await networkHandler.get("$userUri/ckeck-user/${widget.user.id}");
      final responseData = json.decode(response.body);
      print('${response.statusCode} : $responseData');
      if (response.statusCode == 200) {
        setState(() {
          message = responseData['message'];
        });
        if (responseData['status'] == true) {
          setState(() {
            isFollowed = true;
          });
        } else {
          setState(() {
            isFollowed = false;
          });
        }
      } else {
        setState(() {
          message = responseData['message'];
        });
      }
    } catch (e) {
      print(e);
    }
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

  @override
  Widget build(BuildContext context) {
    print("user ! ${widget.user.id}");
    print("user ! ${widget.user.name}");
    print("user ! ${widget.user.email}");

    return Container(
      color: Colors.blue,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () => Get.back(),
                          icon: const Icon(Icons.arrow_back_ios))
                    ],
                  ),
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
                          widget.user.name,
                          style: const TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          widget.user.email,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        ButtonSection(
                          phoneNumber: widget.user.phoneNumber ?? "",
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            message == "followed"
                ? Container(
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
                      child: Column(children: [
                        ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text('Address:'),
                              SizedBox(width: 5.h),
                              Text(widget.user.address ?? ""),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text('Phone Number:'),
                              SizedBox(width: 5.h),
                              Text(widget.user.phoneNumber ?? ""),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text('Gender:'),
                              SizedBox(width: 5.h),
                              Text(widget.user.gender ?? ""),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text('Birthdate:'),
                              SizedBox(width: 5.h),
                              Text(widget.user.dateOfBirth.toString()),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        if (type == 'Laboratoire') ...[
                          ProfileMenu(
                            text: "Add Analyse",
                            icon: "assets/icons/analyses.svg",
                            press: () => Get.to(
                                () => AddAnalyseScreen(user: widget.user)),
                          ),
                        ],
                        if (type == 'Center d\'imagerie Medicale') ...[
                          ProfileMenu(
                            text: "Add Radiographie",
                            icon: "assets/icons/radigraphie.svg",
                            press: () => Get.to(
                                () => AddRadiographieScreen(user: widget.user)),
                          ),
                        ],
                        SizedBox(height: 10.h),
                        if (type == 'Doctor') ...[
                          ProfileMenu(
                            text: "Dossier Medicale ",
                            icon: "assets/icons/5559808.svg",
                            press: () => Get.to(
                              () => DossierMedicaleScreen(
                                user: widget.user,
                              ),
                            ),
                          )
                        ]
                      ]),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
