import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medilink_app/api/global.dart';
import 'package:medilink_app/screens/complete_profile/complete_profile_controller.dart';
import 'package:medilink_app/utils/constants.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CompleteProfileController>(
        init: CompleteProfileController(),
        builder: (controller) {
          return SizedBox(
            height: 150,
            width: 150,
            child: Stack(
              alignment: Alignment.center,
              fit: StackFit.expand,
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  backgroundImage: controller.imageFile == null
                      ? (globalRole == 'HealthcareProvider'
                          ? const AssetImage(kBuilding)
                          : const AssetImage(kProfile))
                      : FileImage(File(controller.imageFile!.path))
                          as ImageProvider,
                ),
                Positioned(
                  right: -16,
                  bottom: 0,
                  child: SizedBox(
                    height: 46,
                    width: 46,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: const BorderSide(color: Colors.white),
                        ),
                        backgroundColor: const Color(0xFFF5F6F9),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (builder) => Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "kchossepic".tr,
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    TextButton.icon(
                                      icon: const Icon(Icons.camera),
                                      onPressed: () {
                                        controller
                                            .takePhoto(ImageSource.camera);
                                      },
                                      label: Text("kcamera".tr),
                                    ),
                                    TextButton.icon(
                                      icon: const Icon(Icons.image),
                                      label: Text('kselectimage'.tr),
                                      onPressed: () {
                                        controller
                                            .takePhoto(ImageSource.gallery);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.camera_alt,
                        color: darkGreyColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
