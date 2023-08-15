import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilink_app/utils/constants.dart';

EasyDateTimeLine DateTimelinePicker() {
  return EasyDateTimeLine(
    initialDate: DateTime.now(),
    headerProps: EasyHeaderProps(
      selectedDateStyle: GoogleFonts.nunitoSans(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: typingColor,
      ),
      monthStyle: GoogleFonts.nunitoSans(
        color: typingColor,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    ),
    activeColor: primaryColor,
    dayProps: const EasyDayProps(
      dayStructure: DayStructure.dayStrDayNum,
      height: 66.0,
      width: 66.0,
      activeMothStrStyle: TextStyle(),
      activeDayNumStyle: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      inactiveDayNumStyle: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: typingColor,
      ),
      inactiveDayStrStyle: TextStyle(
        // fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: typingColor,
      ),
      activeDayStrStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      inactiveDayDecoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    ),
    onDateChange: (selectedDate) {
      // print(selectedDate);
    },
  );
}
