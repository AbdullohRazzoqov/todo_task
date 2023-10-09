import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppStyle {
  AppStyle._();

  static TextStyle get selectDayText => GoogleFonts.poppins(
        textStyle: TextStyle(
          fontSize: 14.sp,
          color: const Color(0xFF292929),
          fontWeight: FontWeight.w600,
          letterSpacing: -0.17,
        ),
      );

  static TextStyle get selectDaySupText => GoogleFonts.poppins(
        textStyle:  TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.17,
          color: const Color(0xFF292929),
        ),
      );
}
