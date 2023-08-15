import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilink_app/components/custom_button.dart';
import 'package:medilink_app/locale/locale.dart';
import 'package:medilink_app/locale/locale_controller.dart';
import 'package:medilink_app/screens/introduction/introduction_screen.dart';
import 'package:medilink_app/utils/constants.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    final MyLocaleController controller = Get.find();
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: defaultScreenPadding.w,
          vertical: defaultScreenPadding.h,
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Spacer(
                flex: 1,
              ),
              Text(
                "kLanguageScreenTitle".tr,
                style: GoogleFonts.nunitoSans(
                  color: typingColor,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              Text(
                "kLanguageScreen".tr,
                style: GoogleFonts.nunitoSans(
                  color: typingColor.withOpacity(0.75),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 36.h),
              SizedBox(
                height: 300.h,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    String? language;
                    String languageCode = Get.locale!.languageCode;
                    if (languageCode == 'en') {
                      if (index == 0) {
                        language = MyLocale().keys[languageCode]!['kEnglish'];
                      } else if (index == 1) {
                        language = MyLocale().keys[languageCode]!['kFrench'];
                      }
                    } else {
                      if (index == 0) {
                        language = MyLocale().keys[languageCode]!['kEnglish'];
                      } else /*if (index == 1)*/ {
                        language = MyLocale().keys[languageCode]!['kFrench'];
                      }
                    }
                    return GestureDetector(
                      onTap: () {
                        if (language ==
                            MyLocale().keys[languageCode]!['kEnglish']) {
                          controller.changeLang('en');
                        } else {
                          controller.changeLang('fr');
                        }
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: index == 0.w ? 0.w : 16.w),
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            height: 80.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(96, 171, 182, 234),
                                  blurRadius: 6.0.r, // soften the shadow
                                  spreadRadius: 0.0, //extend the shadow
                                )
                              ],
                              borderRadius: BorderRadius.all(
                                Radius.circular(12.r),
                              ),
                            ),
                            child: Row(
                              children: [
                                language == "English" || language == "Anglais"
                                    ? Image.asset(
                                        "assets/icons/united-kingdom.png",
                                        width: 44.w,
                                      )
                                    : Image.asset(
                                        "assets/icons/france.png",
                                        width: 44.w,
                                      ),
                                SizedBox(
                                  width: 16.w,
                                ),
                                Text(
                                  language ?? "",
                                  style: GoogleFonts.nunitoSans(
                                    color: typingColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            )),
                      ),
                    );
                  },
                ),
              ),
              const Spacer(
                flex: 2,
              ),
              CustomButton(
                  buttonText: "kbutton1".tr,
                  isLoading: false,
                  onPress: () {
                    Get.to(() => const IntroductionScreen(),
                        transition: Transition.rightToLeft);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
