import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medilink_app/api/global.dart';
import 'package:medilink_app/api/loged_in_user_details.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/components/texte_field_label.dart';
import 'package:medilink_app/models/disease.dart';
import 'package:medilink_app/screens/disease/edit_desease/edit_deases_screen.dart';

class Body extends StatefulWidget {
  const Body({super.key, required this.disease});
  final Disease disease;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late Future<String?> userRole;

  @override
  void initState() {
    super.initState();
    userRole = getUserRole();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        if (userRole == 'Patient') ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () =>
                      Get.off(() => EditDiseaseScreen(disease: widget.disease)),
                  icon: const Icon(Icons.edit_outlined)),
              IconButton(
                  onPressed: () async {
                    try {
                      final response = await networkHandler
                          .delete("$diseaseUri/${widget.disease.id}");
                      final responseData = json.decode(response.body);
                      if (response.statusCode == 200) {
                        final message = responseData['message'];
                        Get.back();
                        Get.snackbar("Disease Deleted", message);
                      } else if (response.statusCode == 500) {
                        final message = responseData['error'];
                        Get.snackbar("Error Deleting Disease", message);
                      }
                    } catch (e) {
                      print(e);
                    } finally {}
                  },
                  icon: const Icon(Icons.delete_outline)),
            ],
          ),
        ],
        Card(
            child: Column(
          children: [
            ListTile(
              title: const TextFieldLabel(
                label: 'Disease Name : ',
              ),
              subtitle: Text(widget.disease.diseaseName),
            ),
            SizedBox(height: 10.h),
            ListTile(
              title: const TextFieldLabel(
                label: 'Speciality : ',
              ),
              subtitle: Text(widget.disease.severity),
            ),
            SizedBox(height: 10.h),
            ListTile(
              title: const TextFieldLabel(label: 'Severity : '),
              subtitle: Text(widget.disease.severity),
            ),
            SizedBox(height: 10.h),
            ListTile(
              title: const TextFieldLabel(label: 'Genetic : '),
              subtitle: Text('${widget.disease.genetic}'),
            ),
            SizedBox(height: 10.h),
            ListTile(
              title: const TextFieldLabel(label: 'Chronic Disease : '),
              subtitle: Text(widget.disease.chronicDisease.toString()),
            ),
            SizedBox(height: 10.h),
            ListTile(
              title: const TextFieldLabel(
                label: 'Detected In Year : ',
              ),
              subtitle: Text(widget.disease.detectedIn.toString()),
            ),
            SizedBox(height: 10.h),
            if (widget.disease.curedIn != null)
              Visibility(
                  visible: true,
                  child: Column(children: [
                    ListTile(
                      title: const TextFieldLabel(
                        label: 'Cured In Year : ',
                      ),
                      subtitle: Text(widget.disease.curedIn.toString()),
                    ),
                    SizedBox(height: 10.h),
                  ])),
            if (widget.disease.symptoms != null &&
                widget.disease.symptoms!.isNotEmpty)
              Visibility(
                visible: true,
                child: Column(
                  children: [
                    ListTile(
                      title: const TextFieldLabel(label: 'Symptoms : '),
                      subtitle: Text(widget.disease.symptoms!),
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            if (widget.disease.medications != null &&
                widget.disease.medications!.isNotEmpty)
              Visibility(
                visible: true,
                child: Column(
                  children: [
                    ListTile(
                      title: const TextFieldLabel(label: 'Medications : '),
                      subtitle: Text('${widget.disease.medications}'),
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ListTile(
              title: const TextFieldLabel(label: 'Family History : '),
              subtitle: Text('${widget.disease.familyHistory}'),
            ),
            SizedBox(height: 10.h),
            ListTile(
              title: const TextFieldLabel(label: 'Recurrence : '),
              subtitle: Text('${widget.disease.recurrence}'),
            ),
            if (widget.disease.notes != null)
              Visibility(
                visible: true,
                child: Column(
                  children: [
                    ListTile(
                      title: const TextFieldLabel(label: 'Notes : '),
                      subtitle: Text('${widget.disease.notes}'),
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
          ],
        )),
      ],
    ));
  }
}
