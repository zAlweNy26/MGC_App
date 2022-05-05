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
  colorScheme: ColorScheme(
    brightness: Brightness.light, 
    primary: mainLight, 
    onPrimary: appWhite, 
    secondary: mainDark, 
    onSecondary: appBlack, 
    error: Colors.red, 
    onError: appBlack, 
    background: appWhite, 
    onBackground: appBlack,
    surface: darken(appWhite, 20),
    onSurface: lighten(appBlack, 20)
  ),
  textTheme: TextTheme(
    headlineLarge: GoogleFonts.nunito(
        color: appBlack, fontSize: 44, fontWeight: FontWeight.bold),
    headlineMedium: GoogleFonts.nunito(
        color: appBlack, fontSize: 32, fontWeight: FontWeight.bold),
    headlineSmall: GoogleFonts.nunito(
        color: appBlack, fontSize: 20, fontWeight: FontWeight.bold),
    titleMedium: GoogleFonts.nunito(
        color: appWhite, fontSize: 20, fontWeight: FontWeight.bold),
    titleSmall: GoogleFonts.nunito(
        color: appBlack, fontSize: 16, fontWeight: FontWeight.bold),
    labelMedium: GoogleFonts.nunito(color: appBlack, fontSize: 16),
    labelSmall: GoogleFonts.nunito(color: appBlack, fontSize: 12),
    bodyLarge: GoogleFonts.nunito(color: appBlack, fontSize: 20),
    bodyMedium: GoogleFonts.nunito(color: appBlack, fontSize: 18),
    bodySmall: GoogleFonts.nunito(color: appBlack, fontSize: 14),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: appBlack,
  backgroundColor: appWhite,
  primaryColor: mainLight,
  colorScheme: ColorScheme(
    brightness: Brightness.dark, 
    primary: mainLight, 
    onPrimary: appWhite, 
    secondary: mainDark, 
    onSecondary: appBlack, 
    error: Colors.red, 
    onError: appBlack, 
    background: appWhite, 
    onBackground: appBlack,
    surface: darken(appWhite, 20),
    onSurface: lighten(appBlack, 20)
  ),
  textTheme: TextTheme(
    headlineLarge: GoogleFonts.nunito(
        color: appWhite, fontSize: 44, fontWeight: FontWeight.bold),
    headlineMedium: GoogleFonts.nunito(
        color: appWhite, fontSize: 32, fontWeight: FontWeight.bold),
    headlineSmall: GoogleFonts.nunito(
        color: appWhite, fontSize: 20, fontWeight: FontWeight.bold),
    titleMedium: GoogleFonts.nunito(
        color: appBlack, fontSize: 20, fontWeight: FontWeight.bold),
    titleSmall: GoogleFonts.nunito(
        color: appWhite, fontSize: 16, fontWeight: FontWeight.bold),
    labelMedium: GoogleFonts.nunito(color: appWhite, fontSize: 16),
    labelSmall: GoogleFonts.nunito(color: appWhite, fontSize: 12),
    bodyLarge: GoogleFonts.nunito(color: appWhite, fontSize: 20),
    bodyMedium: GoogleFonts.nunito(color: appWhite, fontSize: 18),
    bodySmall: GoogleFonts.nunito(color: appWhite, fontSize: 14),
  ),
);

Color darken(Color c, [int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    var f = 1 - percent / 100;
    return Color.fromARGB(
        c.alpha,
        (c.red * f).round(),
        (c.green  * f).round(),
        (c.blue * f).round()
    );
}

Color lighten(Color c, [int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    var p = percent / 100;
    return Color.fromARGB(
        c.alpha,
        c.red + ((255 - c.red) * p).round(),
        c.green + ((255 - c.green) * p).round(),
        c.blue + ((255 - c.blue) * p).round()
    );
}

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
