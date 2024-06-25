import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static const montserratFont = 'Montserrat';
  static final montserrat = GoogleFonts.montserrat();

  static ThemeData theme = ThemeData(
    textTheme: TextTheme(
      displayLarge: montserrat.copyWith(
        fontFamily: montserratFont,
        fontSize: 48,
        fontWeight: FontWeight.w700,
      ),
      displayMedium: montserrat.copyWith(
        fontFamily: montserratFont,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
      displaySmall: montserrat.copyWith(
        fontFamily: montserratFont,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}

class MyColors {
  static const designlyDarkBlue = Color(0xff0E1034);
  static const designlyOrange = Color(0xfff87465);
  static const designlyPurple = Color(0xff58377b);
}
