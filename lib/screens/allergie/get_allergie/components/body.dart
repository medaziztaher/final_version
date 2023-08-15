import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilink_app/api/global.dart';
import 'package:medilink_app/api/paths.dart';
import 'package:medilink_app/components/texte_field_label.dart';
import 'package:medilink_app/models/allergy.dart';
import 'package:medilink_app/screens/allergie/edit_allergie/edit_allergie_screen.dart';
import 'package:medilink_app/settings/networkhandler.dart';

class Body extends StatefulWidget {
  const Body({super.key, required this.allergy});
  final Allergy allergy;
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late Future<String?> userRole;
  NetworkHandler networkHandler = NetworkHandler();

  @override
  void initState() {
    userRole = getUserRole();
    super.initState();
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
                    onPressed: () => Get.off(
                        () => EditAllergyScreen(allergie: widget.allergy)),
                    icon: const Icon(Icons.edit_outlined)),
                IconButton(
                    onPressed: () async {
                      try {
                        final response = await networkHandler
                            .delete("$allergyUri/${widget.allergy.id}");
                        final responseData = json.decode(response.body);
                        if (response.statusCode == 200) {
                          final message = responseData['message'];
                          Get.back();
                          Get.snackbar("Allergy Deleted", message);
                        } else if (response.statusCode == 500) {
                          final message = responseData['error'];
                          Get.snackbar("Error Deleting Allergy", message);
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
                  label: 'Allergie Type : ',
                ),
                subtitle: Text(widget.allergy.type),
              ),
              const SizedBox(height: 10),
              ListTile(
                title: const TextFieldLabel(
                  label: 'Severity : ',
                ),
                subtitle: Text(widget.allergy.severity),
              ),
              const SizedBox(height: 10),
              if (widget.allergy.trigger != null &&
                  widget.allergy.trigger!.isNotEmpty)
                Visibility(
                  visible: true,
                  child: Column(
                    children: [
                      ListTile(
                        title: const TextFieldLabel(label: 'Trigger : '),
                        subtitle: Text(widget.allergy.trigger!),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              if (widget.allergy.reaction != null &&
                  widget.allergy.reaction!.isNotEmpty)
                Visibility(
                  visible: true,
                  child: Column(
                    children: [
                      ListTile(
                        title: const TextFieldLabel(label: 'Reaction : '),
                        subtitle: Text('${widget.allergy.reaction}'),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              if (widget.allergy.yearOfDiscovery != null)
                Visibility(
                  visible: true,
                  child: Column(
                    children: [
                      ListTile(
                        title:
                            const TextFieldLabel(label: 'Year Of Discovery : '),
                        subtitle: Text('${widget.allergy.yearOfDiscovery}'),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              if (widget.allergy.onset != null)
                Visibility(
                  visible: true,
                  child: Column(
                    children: [
                      ListTile(
                        title: const TextFieldLabel(label: 'OnSet : '),
                        subtitle: Text('${widget.allergy.onset}'),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ListTile(
                title: const TextFieldLabel(label: 'Follow Up Status : '),
                subtitle: Text('${widget.allergy.followupStatus}'),
              ),
              const SizedBox(height: 10),
              ListTile(
                title: const TextFieldLabel(label: 'Family History : '),
                subtitle: Text('${widget.allergy.familyHistory}'),
              ),
              const SizedBox(height: 10),
              if (widget.allergy.notes != null)
                Visibility(
                  visible: true,
                  child: Column(
                    children: [
                      ListTile(
                        title: const TextFieldLabel(label: 'Notes : '),
                        subtitle: Text('${widget.allergy.notes}'),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
            ],
          )),
        ],
      ),
    );
  }
}
