import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/components/texte_field_label.dart';
import 'package:medilink_app/models/laboratory_result.dart';
import 'package:medilink_app/screens/analyse/edit_analyse/edit_analyse_screen.dart';
import 'package:medilink_app/settings/networkhandler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Body extends StatelessWidget {
  const Body(
      {Key? key, required this.analyse, required this.userId, this.provider})
      : super(key: key);

  final LaboratoryResult analyse;
  final String userId;
  final String? provider;

  IconData _getFileTypeIcon(String fileUrl) {
    if (fileUrl.contains(RegExp(r'\.(jpe?g|png)'))) {
      return Icons.image;
    } else if (fileUrl.contains(RegExp(r'\.(pdf)'))) {
      return Icons.picture_as_pdf;
    } else if (fileUrl.contains(RegExp(r'\.(docx?|xls(x|)))'))) {
      return Icons.insert_drive_file;
    } else {
      return Icons.insert_drive_file;
    }
  }

  void _openFile(BuildContext context, String fileUrl) {
    print(fileUrl);
    if (fileUrl.contains(RegExp(r'\.(jpe?g|png)'))) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return _buildImageGallery(fileUrl);
      }));
    } else if (fileUrl.contains(RegExp(r'\.(pdf)'))) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return _buildPdfViewer(fileUrl);
      }));
    }
  }

  Widget _buildImageGallery(String imageUrl) {
    return PhotoViewGallery.builder(
      itemCount: 1,
      builder: (context, index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: NetworkImage(imageUrl),
          initialScale: PhotoViewComputedScale.contained,
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 2,
        );
      },
    );
  }

  Widget _buildPdfViewer(String pdfUrl) {
    return SfPdfViewer.network(pdfUrl, enableDocumentLinkAnnotation: false);
  }

  @override
  Widget build(BuildContext context) {
    NetworkHandler networkHandler = NetworkHandler();
    return SafeArea(
      child: Column(
        children: [
          if (userId == analyse.patient || userId == analyse.provider) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => Get.off(() => EditAnalyseScreen(
                        analyse: analyse,
                        userId: userId,
                      )),
                  icon: const Icon(Icons.edit_outlined),
                ),
                IconButton(
                  onPressed: () async {
                    try {
                      final response = await networkHandler
                          .delete("$laboratoryResultUri/${analyse.id}");
                      final responseData = json.decode(response.body);
                      print(responseData);
                      if (response.statusCode == 200) {
                        final message = responseData['message'];
                        Get.back();
                        Get.snackbar("Analyse Deleted", message);
                      } else if (response.statusCode == 500) {
                        final message = responseData['message'];
                        Get.snackbar("Error Deleting Analyse", message);
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  icon: const Icon(Icons.delete_outline),
                ),
              ],
            ),
          ],
          Card(
            child: Column(
              children: [
                ListTile(
                  title: const TextFieldLabel(label: 'Test Name : '),
                  subtitle: Text(analyse.testName),
                ),
                SizedBox(height: 10.h),
                ListTile(
                  title: const TextFieldLabel(label: 'Reason : '),
                  subtitle: Text(analyse.reason),
                ),
                SizedBox(height: 10.h),
                ListTile(
                  title: const TextFieldLabel(label: 'Result : '),
                  subtitle: Text(analyse.result),
                ),
                SizedBox(height: 10.h),
                ListTile(
                    title: const TextFieldLabel(label: 'Date : '),
                    subtitle: Text(analyse.date.toString())),
                SizedBox(height: 10.h),
                if (analyse.units != null && analyse.units!.isNotEmpty)
                  Visibility(
                    visible: true,
                    child: Column(
                      children: [
                        ListTile(
                          title: const TextFieldLabel(label: 'Units : '),
                          subtitle: Text('${analyse.units}'),
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                if (analyse.referenceRange != null &&
                    analyse.referenceRange!.isNotEmpty)
                  Visibility(
                    visible: true,
                    child: Column(
                      children: [
                        ListTile(
                          title:
                              const TextFieldLabel(label: 'ReferenceRange : '),
                          subtitle: Text('${analyse.referenceRange}'),
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                ListTile(
                  title: const TextFieldLabel(label: 'AbnormalFlag : '),
                  subtitle: Text('${analyse.abnormalFlag}'),
                ),
                SizedBox(height: 10.h),
                if (analyse.provider != null) ...[
                  ListTile(
                    title: const Text('Provider: '),
                    subtitle: Text('$provider'),
                  ),
                ],
                if (analyse.files != null && analyse.files!.isNotEmpty)
                  Column(
                    children: [
                      const Text(
                        'Files:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: analyse.files!.length,
                        itemBuilder: (context, index) {
                          final file = analyse.files![index];
                          return ListTile(
                            leading: Icon(_getFileTypeIcon(
                                file)), // Implement _getFileTypeIcon
                            title: Text(file.split('/').last),
                            onTap: () {
                              print(file);
                              _openFile(context, file);
                            },
                          );
                        },
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
