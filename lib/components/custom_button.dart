import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilink_app/utils/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonText,
    required this.isLoading,
    required this.onPress,
  });

  final String buttonText;
  final bool isLoading;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          side: BorderSide.none,
        ),
        onPressed: onPress,
        child: isLoading == true
            ? SizedBox(
                width: 30.w,
                height: 30.h,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Text(
                buttonText,
                style: GoogleFonts.nunitoSans(
                  fontSize: 17.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
      ),
    );
  }
}
