import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:medilink_app/components/custom_app_bar.dart';
import 'package:medilink_app/components/custom_button.dart';
import 'package:medilink_app/components/texte_field_label.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/navigation/patient/patient_navigation_controller.dart';
import 'package:medilink_app/screens/prescriptions/add_presc/add_prescription_controller.dart';
import 'package:medilink_app/utils/constants.dart';

class Body extends StatefulWidget {
  const Body({super.key, required this.user, required this.userId});
  final User user;
  final String userId;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String medicationType = "Pills";
  TimeOfDay? selectedTime;
  DateTime initialDate = DateTime.now();
  TimeOfDay initialTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    PatientNavigationController patientNavigationController =
        Get.put(PatientNavigationController());

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: defaultScreenPadding,
          bottom: defaultScreenPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: defaultScreenPadding,
              ),
              // Custom app bar
              child: CustomAppBar(
                  title: "Add new medication",
                  onBack: () {
                    patientNavigationController.updateCurrentHomePage(
                        patientNavigationController.previousHomePage);
                  },
                  withoutNotifIcon: true),
            ),
            const SizedBox(
              height: 26,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultScreenPadding),
              child: GetBuilder<AddPrescriptionController>(
                  init: AddPrescriptionController(user: widget.user),
                  builder: (controller) {
                    return Form(
                      key: controller.formKeyPrescription,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 26,
                          ),
                          Text(
                            "Name of medication",
                            style: GoogleFonts.nunitoSans(
                              fontSize: 20,
                              color: typingColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              // border: Border.all(
                              //   color: typingColor.withOpacity(0.1),
                              //   width: 2,
                              // ),
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            ),
                            child: Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller:
                                            controller.medicamentController,
                                        onSaved: (newValue) => controller
                                            .medicamentController
                                            .text = newValue!,
                                        style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: typingColor.withOpacity(0.8),
                                        ),
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: BorderSide.none,
                                            ),
                                            hintText: "Enter Medication's Name",
                                            hintStyle: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                              color:
                                                  typingColor.withOpacity(0.8),
                                            )),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2,
                                      height: 36,
                                      child: Container(
                                        color: Colors.grey[300],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    const ImageIcon(
                                      AssetImage("assets/icons/scan.png"),
                                      color: primaryColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 26,
                          ),
                          const TextFieldLabel(label: "Dosage"),
                          const SizedBox(
                            height: 12,
                          ),
                          Container(
                            height: 60,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const ImageIcon(
                                  AssetImage("assets/icons/pill.png"),
                                  color: primaryColor,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    onChanged: (value) => controller
                                        .dosageController = int.tryParse(value),
                                    keyboardType: TextInputType.number,
                                    style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: typingColor.withOpacity(0.8),
                                    ),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none,
                                      ),
                                      hintText: "Type dosage quantity",
                                      hintStyle: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: typingColor.withOpacity(0.8),
                                      ),
                                    ),
                                    // inputFormatters: [
                                    //   FilteringTextInputFormatter.digitsOnly
                                    // ],
                                  ),
                                ),
                                DropdownButton<String>(
                                  iconSize: 30,
                                  value: medicationType,
                                  items: <String>['Pills', 'Liquid', 'Tablet']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: GoogleFonts.nunitoSans(
                                          fontSize: 16,
                                          color: typingColor,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  // Step 5.
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      medicationType = newValue!;
                                    });
                                    controller.typeController.text = newValue!;
                                  },
                                  underline: Container(),
                                ),
                              ],
                            ),
                          ),

                          const TextFieldLabel(label: "Frequency"),
                          const SizedBox(
                            height: 12,
                          ),
                          Container(
                            height: 60,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            ),
                            child: Expanded(
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const ImageIcon(
                                    AssetImage("assets/icons/calendar-2.png"),
                                    color: primaryColor,
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Expanded(
                                    child: DropdownButton<String>(
                                      iconSize: 0.0,
                                      value: controller.frequencyController
                                          .toString(),
                                      items: <String>[
                                        '1',
                                        '2',
                                        '3',
                                        '4',
                                        '5',
                                        '6',
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: GoogleFonts.nunitoSans(
                                              fontSize: 16,
                                              color: typingColor,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      // Step 5.
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          controller.frequencyController =
                                              int.parse(newValue!);
                                        });
                                      },
                                      underline: Container(),
                                    ),
                                  ),
                                  Text(
                                    "Times",
                                    style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: typingColor),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 26,
                          ),
                          const TextFieldLabel(label: "Date Debut"),
                          const SizedBox(
                            height: 12,
                          ),
                          GestureDetector(
                            onTap: () async {
                              final DateTime? selectedDate =
                                  await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100),
                              );

                              if (selectedDate != null) {
                                final DateFormat formatter =
                                    DateFormat('yyyy-MM-dd');
                                final String formattedDate =
                                    formatter.format(selectedDate);
                                controller.dateDebutController.text =
                                    formattedDate;
                              }
                            },
                            child: Container(
                              height: 60,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              decoration: const BoxDecoration(
                                //
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const ImageIcon(
                                    AssetImage("assets/icons/calendar.png"),
                                    color: primaryColor,
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Expanded(
                                    child: Text(
                                      controller.dateDebutController.text
                                              .isNotEmpty
                                          ? controller.dateDebutController.text
                                          : "Select Date",
                                      style: GoogleFonts.nunitoSans(
                                        fontSize: 16,
                                        color: typingColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          const TextFieldLabel(label: "Date Fin"),
                          const SizedBox(
                            height: 12,
                          ),
                          GestureDetector(
                            onTap: () async {
                              final DateTime? selectedDate =
                                  await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100),
                              );

                              if (selectedDate != null) {
                                final DateFormat formatter =
                                    DateFormat('yyyy-MM-dd');
                                final String formattedDate =
                                    formatter.format(selectedDate);
                                controller.dateFinController.text =
                                    formattedDate;
                              }
                            },
                            child: Container(
                              height: 60,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                              ),
                              child: Expanded(
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const ImageIcon(
                                      AssetImage("assets/icons/calendar.png"),
                                      color: primaryColor,
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Expanded(
                                      child: Text(
                                        controller.dateFinController.text
                                                .isNotEmpty
                                            ? controller.dateFinController.text
                                            : "Select Date",
                                        style: GoogleFonts.nunitoSans(
                                          fontSize: 16,
                                          color: typingColor,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 26,
                          ),
                          const TextFieldLabel(label: "Alarme"),
                          const SizedBox(
                            height: 12,
                          ),
                          SizedBox(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.reminders.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                TimeOfDay notification = controller.reminders[
                                    index]; // Change 'final' to 'TimeOfDay'
                                return Padding(
                                  padding:
                                      EdgeInsets.only(top: index == 0 ? 0 : 12),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 60,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(16)),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              const ImageIcon(
                                                AssetImage(
                                                    "assets/icons/bell-ring.png"),
                                                color: primaryColor,
                                              ),
                                              const SizedBox(width: 26),
                                              Expanded(
                                                child: Text(
                                                  '${notification.hour}:${notification.minute}', // Display the time
                                                  style: GoogleFonts.nunitoSans(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w800,
                                                    color: typingColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12.0),
                                      GestureDetector(
                                        onTap: () async {
                                          TimeOfDay? notificationTime =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: notification,
                                            initialEntryMode:
                                                TimePickerEntryMode.dial,
                                          );

                                          if (notificationTime != null) {
                                            setState(() {
                                              notification = notificationTime;
                                              controller.reminders[index] =
                                                  notification; // Update the reminder in the list
                                            });
                                          }
                                        },
                                        child: Container(
                                          height: 60,
                                          width: 60,
                                          decoration: const BoxDecoration(
                                            color: lightBlueColor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                          ),
                                          padding: const EdgeInsets.all(16),
                                          child: const ImageIcon(
                                            AssetImage("assets/icons/edit.png"),
                                            size: 20,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 26,
                          ),
                          // const TextFieldLabel(label: "Instructions"),
                          // const SizedBox(
                          //   height: 12,
                          // ),
                          // TextFormField(
                          //   onSaved: (newValue) => controller
                          //       .instructionsController.text = newValue!,
                          //   validator: (value) =>
                          //       controller.validateInstructions(value),
                          //   controller: controller.instructionsController,
                          //   keyboardType: TextInputType.multiline,
                          //   maxLines: 3,
                          //   style: GoogleFonts.nunitoSans(
                          //     fontWeight: FontWeight.w700,
                          //     fontSize: 16,
                          //     color: typingColor.withOpacity(0.8),
                          //   ),
                          //   decoration: InputDecoration(
                          //       border: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(24),
                          //         borderSide: BorderSide.none,
                          //       ),
                          //       fillColor: Colors.white,
                          //       filled: true,
                          //       hintText:
                          //           "Enter Medication's usage instructions",
                          //       hintStyle: GoogleFonts.nunitoSans(
                          //         fontWeight: FontWeight.w700,
                          //         fontSize: 16,
                          //         color: typingColor.withOpacity(0.8),
                          //       )),
                          // ),

                          Obx(() {
                            return CustomButton(
                                isLoading: controller.isLoading.value,
                                buttonText: "kbutton1".tr,
                                onPress: () async {
                                  controller.addPrescription();
                                });
                          }),
                          const SizedBox(
                            height: 26,
                          ),
                          //FormError(errors: controller.errors),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
