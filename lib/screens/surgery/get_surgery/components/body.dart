import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/models/surgery.dart';
import 'package:medilink_app/screens/surgery/edit_surgery/edit_surgery_screen.dart';
import 'package:medilink_app/settings/networkhandler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Body extends StatelessWidget {
  const Body(
      {Key? key, required this.surgerie, required this.userId, this.provider})
      : super(key: key);

  final Surgery surgerie;
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
          if (userId == surgerie.patient || userId == surgerie.provider) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => Get.off(() => EditSurgerieScreen(
                        surgerie: surgerie,
                        userId: userId,
                      )),
                  icon: const Icon(Icons.edit_outlined),
                ),
                IconButton(
                  onPressed: () async {
                    try {
                      final response = await networkHandler
                          .delete("$surgerieUri/${surgerie.id}");
                      final responseData = json.decode(response.body);
                      print(responseData);
                      if (response.statusCode == 200) {
                        final message = responseData['message'];
                        Get.back();
                        Get.snackbar("surgerie Deleted", message);
                      } else if (response.statusCode == 500) {
                        final message = responseData['error'];
                        Get.snackbar("Error Deleting surgerie", message);
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
                  title: const Text('Type : '),
                  subtitle: Text('${surgerie.type}}'),
                ),
                ListTile(
                  title: const Text('Description : '),
                  subtitle: Text(surgerie.description),
                ),
                ListTile(
                  title: const Text('Complications : '),
                  subtitle: Text('${surgerie.outcome}'),
                ),
                ListTile(
                  title: const Text('Anesthesia : '),
                  subtitle: Text('${surgerie.anesthesia}'),
                ),
                if (provider != null) ...[
                  ListTile(
                    title: const Text('Provider: '),
                    subtitle: Text(provider!),
                  ),
                ],
                ListTile(
                  title: const Text('Date: '),
                  subtitle: Text('${surgerie.date}'),
                ),
                const SizedBox(height: 10),
                if (surgerie.files != null && surgerie.files!.isNotEmpty)
                  Column(
                    children: [
                      const Text('Files:',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: surgerie.files!.length,
                        itemBuilder: (context, index) {
                          final file = surgerie.files![index];
                          return ListTile(
                            leading: Icon(_getFileTypeIcon(file)),
                            title: Text(file.split('/').last),
                            onTap: () {
                              _openFile(context, file);
                            },
                          );
                        },
                      ),
                    ],
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
