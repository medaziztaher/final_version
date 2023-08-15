import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medilink_app/screens/emergency_contact/add_emergency_conatct/add_emergency_contact_controller.dart';
import 'package:medilink_app/utils/constants.dart';


class EmergencyContactPic extends StatelessWidget {
  const EmergencyContactPic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmergencyContactController>(
        init: EmergencyContactController(),
        builder: (controller) {
          return SizedBox(
            height: 150.h,
            width: 150.w,
            child: Stack(
              alignment: Alignment.center,
              fit: StackFit.expand,
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  backgroundImage: controller.imageFile == null
                      ? const AssetImage(kProfile)
                      : FileImage(File(controller.imageFile!.path))
                          as ImageProvider,
                ),
                Positioned(
                  right: -16,
                  bottom: 0,
                  child: SizedBox(
                    height: 46.h,
                    width: 46.w,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.r),
                          side: const BorderSide(color: Colors.white),
                        ),
                        backgroundColor: const Color(0xFFF5F6F9),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (builder) => Container(
                            height: 100.h,
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 20.w,
                            ),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "kchossepic".tr,
                                  style: TextStyle(
                                    fontSize: 20.0.sp,
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
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
