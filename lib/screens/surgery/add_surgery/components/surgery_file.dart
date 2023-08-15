import 'dart:io';
import 'package:medilink_app/screens/surgery/add_surgery/add_surgery_controller.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medilink_app/components/custom_button.dart';
import 'package:medilink_app/components/texte_field_label.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/utils/constants.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class SurgerieFiles extends StatelessWidget {
  const SurgerieFiles({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddSurgerieController>(
      init: AddSurgerieController(user: user),
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const TextFieldLabel(label: "Analyse Files"),
            const SizedBox(
              height: 6,
            ),
            CustomButton(
              buttonText: "Open File Picker",
              onPress: () {
                controller.openFilePicker();
              },
              isLoading: false,
            ),
            const SizedBox(
              height: 6,
            ),
            CustomButton(
              buttonText: "Open Camera",
              onPress: () {
                controller.takePhoto(ImageSource.camera);
              },
              isLoading: false,
            ),
            // SizedBox(height: 16.0),
            controller.filePaths.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Selected Files:',
                        style: GoogleFonts.nunitoSans(
                          color: typingColor.withOpacity(0.75),
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  )
                : Container(),
            SizedBox(
              child: ListView.builder(
                  itemCount: controller.filePaths.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final filePath = controller.filePaths[index];
                    final fileName = path.basename(filePath);
                    return Padding(
                      padding: EdgeInsets.only(
                          top: index == 0 ? 0 : 12,
                          bottom:
                              index == controller.filePaths.length ? 12 : 0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(96, 171, 182, 234),
                              blurRadius: 6.0, // soften the shadow
                              spreadRadius: 0.0, //extend the shadow
                            )
                          ],
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        child: filePath.toLowerCase().endsWith('.pdf')
                            ? GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SfPdfViewer.file(File(filePath)),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/icons/pdf.png",
                                            width: 44,
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          SizedBox(
                                            width: 200,
                                            child: Text(
                                              fileName,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.nunitoSans(
                                                color: typingColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () =>
                                            controller.deleteFile(filePath),
                                        child: const ImageIcon(
                                          AssetImage("assets/icons/delete.png"),
                                          color: typingColor,
                                          size: 33,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : filePath.toLowerCase().endsWith('.txt')
                                ? GestureDetector(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SfPdfViewer.file(File(filePath)),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              "assets/icons/txt.png",
                                              width: 44,
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            SizedBox(
                                              width: 200,
                                              child: Text(
                                                fileName,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.nunitoSans(
                                                  color: typingColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () =>
                                              controller.deleteFile(filePath),
                                          child: const ImageIcon(
                                            AssetImage(
                                                "assets/icons/delete.png"),
                                            color: typingColor,
                                            size: 33,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : filePath.toLowerCase().endsWith('.doc')
                                    ? GestureDetector(
                                        onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SfPdfViewer.file(
                                                    File(filePath)),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset(
                                                  "assets/icons/doc.png",
                                                  width: 44,
                                                ),
                                                const SizedBox(
                                                  width: 12,
                                                ),
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    fileName,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        GoogleFonts.nunitoSans(
                                                      color: typingColor,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            GestureDetector(
                                              onTap: () => controller
                                                  .deleteFile(filePath),
                                              child: const ImageIcon(
                                                AssetImage(
                                                    "assets/icons/delete.png"),
                                                color: typingColor,
                                                size: 33,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : filePath.toLowerCase().endsWith('.docx')
                                        ? GestureDetector(
                                            onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SfPdfViewer.file(
                                                        File(filePath)),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      "assets/icons/docx.png",
                                                      width: 44,
                                                    ),
                                                    const SizedBox(
                                                      width: 12,
                                                    ),
                                                    SizedBox(
                                                      width: 200,
                                                      child: Text(
                                                        fileName,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: GoogleFonts
                                                            .nunitoSans(
                                                          color: typingColor,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                GestureDetector(
                                                  onTap: () => controller
                                                      .deleteFile(filePath),
                                                  child: const ImageIcon(
                                                    AssetImage(
                                                        "assets/icons/delete.png"),
                                                    color: typingColor,
                                                    size: 33,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : GestureDetector(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      "assets/icons/image.png",
                                                      width: 44,
                                                    ),
                                                    const SizedBox(
                                                      width: 12,
                                                    ),
                                                    SizedBox(
                                                      width: 200,
                                                      child: Text(
                                                        fileName,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: GoogleFonts
                                                            .nunitoSans(
                                                          color: typingColor,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                GestureDetector(
                                                  onTap: () => controller
                                                      .deleteFile(filePath),
                                                  child: const ImageIcon(
                                                    AssetImage(
                                                        "assets/icons/delete.png"),
                                                    color: typingColor,
                                                    size: 33,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Scaffold(
                                                    appBar: AppBar(),
                                                    body: Container(
                                                      child: PhotoViewGallery
                                                          .builder(
                                                        itemCount: 1,
                                                        builder:
                                                            (context, index) {
                                                          return PhotoViewGalleryPageOptions(
                                                            imageProvider:
                                                                FileImage(File(
                                                                    filePath)),
                                                            initialScale:
                                                                PhotoViewComputedScale
                                                                    .contained,
                                                            minScale:
                                                                PhotoViewComputedScale
                                                                        .contained *
                                                                    0.8,
                                                            maxScale:
                                                                PhotoViewComputedScale
                                                                        .covered *
                                                                    2,
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                      ),
                    );
                  }),
            ),
          ],
        );
      },
    );
  }
}
