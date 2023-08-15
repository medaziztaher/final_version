import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilink_app/components/custom_button.dart';
import 'package:medilink_app/screens/authentification/signup/signup_controller.dart';
import 'package:medilink_app/screens/authentification/signup/signup_screen.dart';
import 'package:medilink_app/utils/constants.dart';

class RegisterTypedPage extends StatefulWidget {
  const RegisterTypedPage({super.key});

  @override
  State<RegisterTypedPage> createState() => RegisterTypedPageState();
}

class RegisterTypedPageState extends State<RegisterTypedPage> {
  final SignupController _signupController = Get.put(SignupController());
  String roleText = "";
  String typeText = "";
  int _isPressed = -1;
  void _handlePress(int index) {
    setState(
      () {
        _isPressed = index;
        typeText = types[index].type;
        roleText = types[index].role;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: defaultScreenPadding,
            vertical: defaultScreenPadding,
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: ImageIcon(
                    AssetImage("assets/icons/back.png"),
                    color: typingColor,
                    size: 26.sp,
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                Text(
                  "Select your role",
                  style: GoogleFonts.nunitoSans(
                    color: typingColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 26.sp,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Join as a Doctor, Patient, Laboratory, or Pharmacy",
                  textScaleFactor: 1,
                  style: GoogleFonts.nunitoSans(
                    color: typingColor.withOpacity(0.75),
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(
                  height: 26.sp,
                ),
                Container(
                  width: MediaQuery.of(context).size.width.w,
                  height: MediaQuery.of(context).size.height * 0.50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromRGBO(213, 212, 218, 1),
                    ),
                    borderRadius: BorderRadius.circular(18),
                    color: const Color.fromARGB(255, 244, 242, 242),
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return GridView.count(
                        crossAxisCount: 2,
                        children: types.asMap().entries.map((type) {
                          final int index = type.key;
                          return GestureDetector(
                            onTap: () => _handlePress(index),
                            child: Container(
                              margin: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 5.w,
                                  strokeAlign: 0,
                                  color: (_isPressed == index)
                                      ? const Color.fromARGB(255, 108, 211, 252)
                                      : const Color.fromARGB(
                                          255, 244, 242, 242),
                                ),
                                color: const Color.fromARGB(255, 232, 232, 232),
                                borderRadius: BorderRadius.circular(100.r),
                              ),
                              child: Container(
                                padding: EdgeInsets.all(18.w),
                                child: Image.asset(
                                  type.value.img,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 26.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      typeText,
                      style: GoogleFonts.nunitoSans(
                        color: typingColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 26.h,
                ),
                CustomButton(
                    buttonText: "kbutton1".tr,
                    isLoading: false,
                    onPress: () {
                      if (typeText.isNotEmpty) {
                        _signupController.onChangedRole(roleText);
                        _signupController.onChangedType(typeText);

                        Get.to(() => SignUpScreen(),
                            transition: Transition.rightToLeft);
                      }
                    }),
                Spacer(
                  flex: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TypeList {
  final String type, img, role;

  TypeList({
    this.role = "",
    this.type = "",
    this.img = "",
  });
}

List<TypeList> types = [
  TypeList(
      img: 'assets/images/types_image/patient.png',
      role: "Patient",
      type: "Patient"),
  TypeList(
      type: "Laboratoire",
      img: 'assets/images/types_image/laboratory.png',
      role: "HealthcareProvider"),
  TypeList(
      type: "Center d\'imagerie Medicale",
      img: 'assets/images/types_image/pharmacy.png',
      role: "HealthcareProvider"),
  TypeList(
      img: 'assets/images/types_image/doctor.png',
      role: "HealthcareProvider",
      type: "Doctor"),
];