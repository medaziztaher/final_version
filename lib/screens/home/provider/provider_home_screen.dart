import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/components/custom_search_bar.dart';
import 'package:medilink_app/components/home_app_bar.dart';
import 'package:medilink_app/components/section_devider.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/screens/home/home_controller.dart';
import 'package:medilink_app/screens/user/user_screen.dart';
import 'package:medilink_app/settings/networkhandler.dart';
import 'package:medilink_app/settings/realtime.dart';
import 'package:medilink_app/utils/constants.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  bool isLoading = false;
  List<User> users = [];
  List<User> patients = [];
  HomeData homeController = HomeData();
  final socket = SocketClient.instance.socket!;
  NetworkHandler networkHandler = NetworkHandler();

  Future<void> getPendingPatients() async {
    setState(() {
      isLoading = true;
    });
    try {
      var response =
          await networkHandler.get("$userUri/user/list-of-invitations");
      print("response : $response");
      final responseData = json.decode(response.body);
      print(
          "status Code : ${response.statusCode}  ;\n response body : $responseData");
      if (response.statusCode == 200) {
        final data = responseData['data'] as List<dynamic>;
        final newUsers =
            data.map((item) => User.fromJson(item)).toList(growable: false);
        users = newUsers;
      } else {
        var message = json.decode(response.body)['message'];
        Get.snackbar("Error", message);
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> getPatients() async {
    setState(() {
      isLoading = true;
    });
    try {
      var response = await networkHandler.get("$providerUri/patients");
      final ResponseData = json.decode(response.body);
      if (response.statusCode == 200) {
        final data = ResponseData['data'] as List<dynamic>;
        final patient =
            data.map((item) => User.fromJson(item)).toList(growable: false);
        patients = patient;
      } else {
        var message = json.decode(response.body)['message'];
        Get.snackbar("${response.statusCode}", message);
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
    socket.on('followRequestError', (data) {
      if (mounted) {}
    });
    socket.on('followRequest', (data) {
      if (mounted) {
        _initializeUser();
      }
    });
    socket.on('followRequestReceived', (data) {
      if (mounted) {
        _initializeUser();
      }
    });
    socket.on('followRequestApproved', (data) {
      if (mounted) {
        _initializeUser();
      }
    });
    socket.on('followRequestdeclined', (data) {
      if (mounted) {
        _initializeUser();
      }
    });
    socket.on('declineRequestError', (data) {
      if (mounted) {
        _initializeUser();
      }
    });
    socket.on('approveRequestError', (data) {
      if (mounted) {
        _initializeUser();
      }
    });
    socket.on('unfollowSuccess', (data) {
      if (mounted) {
        _initializeUser();
      }
    });
    socket.on('cancelRequestSuccess', (data) {
      if (mounted) {
        _initializeUser();
      }
    });
  }

  Future<void> _initializeUser() async {
    getPendingPatients();
    getPatients();
  }

  @override
  void initState() {
    super.initState();
    _initializeUser();
    _setupSocketListeners();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(
          right: defaultScreenPadding,
          left: defaultScreenPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: defaultScreenPadding,
            ),
            const HomeAppBar(),
            const SizedBox(
              height: 30,
            ),
            const CustomSearchBar(
                searchText: "Search Patients, Medical files.."),
            const SizedBox(
              height: 26,
            ),
            SectionDivider(
              sectionTitle: "Pending Patients",
              onTap: () => {},
            ),
            const SizedBox(
              height: 14,
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                    color: primaryColor,
                  ))
                : users.isEmpty
                    ? Center(
                        child: Text(
                        'No pending patients',
                        style: GoogleFonts.nunitoSans(
                          color: typingColor.withOpacity(0.75),
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ))
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final user = users[index];
                          return GestureDetector(
                            onTap: () =>
                                Get.to(() => UserScreen(userId: user.id)),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    CachedNetworkImageProvider(user.picture!),
                              ),
                              title: Text(user.name),
                            ),
                          );
                        },
                      ),
            const SizedBox(
              height: 26,
            ),
            Text(
              "Your Patients",
              style: GoogleFonts.nunitoSans(
                color: typingColor,
                fontWeight: FontWeight.w900,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                    color: primaryColor,
                  ))
                : patients.isEmpty
                    ? const Center(child: Text('You have no patients!'))
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: patients.length,
                        itemBuilder: (context, index) {
                          final patient = patients[index];
                          return GestureDetector(
                            onTap: () =>
                                Get.to(() => UserScreen(userId: patient.id)),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: CachedNetworkImageProvider(
                                    patient.picture!,
                                    maxWidth: 50),
                              ),
                              title: Text(
                                patient.name,
                                style: GoogleFonts.nunitoSans(
                                    color: typingColor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          );
                        },
                      ),
          ],
        ),
      ),
    );
  }
}
