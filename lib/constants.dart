import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color mainLight = const Color(0xFFF50057);
Color mainDark = const Color(0xFFD0004A);
Color appWhite = Colors.grey.shade200;
Color appBlack = Colors.grey.shade900;

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: appWhite,
  backgroundColor: appBlack,
  primaryColor: mainLight,
  textTheme: TextTheme(
    headlineLarge: GoogleFonts.dosis(
        color: appBlack, fontSize: 48, fontWeight: FontWeight.bold),
    headlineMedium: GoogleFonts.dosis(
        color: appBlack, fontSize: 24, fontWeight: FontWeight.bold),
    titleMedium: GoogleFonts.dosis(
        color: appWhite, fontSize: 24, fontWeight: FontWeight.bold),
    titleSmall: GoogleFonts.dosis(
        color: appBlack, fontSize: 18, fontWeight: FontWeight.bold),
    labelSmall: GoogleFonts.dosis(color: appBlack, fontSize: 14),
    bodyMedium: GoogleFonts.dosis(color: appBlack, fontSize: 24),
    bodySmall: GoogleFonts.dosis(color: appBlack, fontSize: 18),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: appBlack,
  backgroundColor: appWhite,
  primaryColor: mainLight,
  textTheme: TextTheme(
    headlineLarge: GoogleFonts.dosis(
        color: appWhite, fontSize: 48, fontWeight: FontWeight.bold),
    headlineMedium: GoogleFonts.dosis(
        color: appWhite, fontSize: 24, fontWeight: FontWeight.bold),
    titleMedium: GoogleFonts.dosis(
        color: appBlack, fontSize: 24, fontWeight: FontWeight.bold),
    titleSmall: GoogleFonts.dosis(
        color: appWhite, fontSize: 18, fontWeight: FontWeight.bold),
    labelSmall: GoogleFonts.dosis(color: appWhite, fontSize: 14),
    bodyMedium: GoogleFonts.dosis(color: appWhite, fontSize: 24),
    bodySmall: GoogleFonts.dosis(color: appWhite, fontSize: 18),
  ),
);

/*class BottomRoundedCorners extends NeumorphicPathProvider {
  @override
  bool shouldReclip(NeumorphicPathProvider oldClipper) => true;

  @override
  Path getPath(Size size) {
    return Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height - 75)
      ..quadraticBezierTo(size.width, size.height, size.width - 75, size.height)
      ..lineTo(0, size.height)
      ..close();
  }

  @override
  bool get oneGradientPerPath => false;
}*/
