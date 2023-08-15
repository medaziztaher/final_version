import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilink_app/components/custom_button.dart';
import 'package:medilink_app/screens/authentification/signin/signin_screen.dart';
import 'package:medilink_app/screens/introduction/components/content_model.dart';
import 'package:medilink_app/utils/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _controller = PageController(initialPage: 0);
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const BackButton(
            color: Colors.white,
          ),
        ),
        body: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width.w,
              height: (MediaQuery.of(context).size.height - 360).h,
              child: PageView.builder(
                controller: _controller,
                itemCount: contents.length,
                onPageChanged: (int index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (_, i) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width.w,
                    height: (MediaQuery.of(context).size.height - 360).h,
                    child: Image.asset(
                      contents[i].image,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  constraints:
                      BoxConstraints(minHeight: 380.h, minWidth: 380.w),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30.r),
                        topLeft: Radius.circular(30.r)),
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              contents[_currentIndex].title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: const Color(0xff474d62),
                                  fontSize: 26.sp,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: GoogleFonts.mulish().fontFamily),
                            ),
                            SizedBox(height: 26.h),
                            Text(
                              contents[_currentIndex].discruption,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xff9e9ea7),
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        SmoothPageIndicator(
                          controller: _controller,
                          count: 3,
                          effect: const WormEffect(
                            activeDotColor: Color.fromARGB(255, 108, 211, 252),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: defaultScreenPadding.w),
                          child: CustomButton(
                            buttonText: (_currentIndex == contents.length - 1)
                                ? "kGetStarted".tr
                                : "kbutton1".tr,
                            isLoading: false,
                            onPress: () {
                              _controller.nextPage(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.ease);
                              if (_currentIndex == contents.length - 1) {
                                Get.to(
                                  () => const SignInScreen(),
                                  transition: Transition.rightToLeft,
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
