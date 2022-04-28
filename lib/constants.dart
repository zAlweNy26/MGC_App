import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color mainLight = const Color(0xFFF50057);
Color mainDark = const Color(0xFFD0004A);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  primaryColor: mainLight,
  textTheme: TextTheme(
    headline1: GoogleFonts.dosis(color: Colors.black, fontSize: 48, fontWeight: FontWeight.bold),
    headline4: GoogleFonts.dosis(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
    headline5: GoogleFonts.dosis(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
    headline6: GoogleFonts.dosis(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
    bodyText1: GoogleFonts.dosis(color: Colors.black, fontSize: 24),
    bodyText2: GoogleFonts.dosis(color: Colors.black, fontSize: 18),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.grey.shade900,
  primaryColor: mainLight,
  textTheme: TextTheme(
    headline1: GoogleFonts.dosis(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold),
    headline4: GoogleFonts.dosis(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
    headline5: GoogleFonts.dosis(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
    bodyText1: GoogleFonts.dosis(color: Colors.white, fontSize: 24),
    bodyText2: GoogleFonts.dosis(color: Colors.white, fontSize: 18),
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
