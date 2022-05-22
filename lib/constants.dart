import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color primaryColor = const Color(0xFF008AD4);
Color secondaryColor = const Color(0xFFFAB72B);
Color appWhite = Colors.grey.shade200;
Color appBlack = Colors.grey.shade900;

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: appWhite,
  backgroundColor: appBlack,
  primaryColor: primaryColor,
  colorScheme: ColorScheme(
    brightness: Brightness.light, 
    primary: primaryColor, 
    onPrimary: appWhite, 
    secondary: secondaryColor, 
    onSecondary: appBlack, 
    error: Colors.red, 
    onError: appBlack, 
    background: appWhite, 
    onBackground: appBlack,
    surface: appWhite,
    onSurface: appBlack
  ),
  textTheme: TextTheme(
    headlineLarge: GoogleFonts.nunito(
        color: appBlack, fontSize: 44, fontWeight: FontWeight.bold),
    headlineMedium: GoogleFonts.nunito(
        color: appBlack, fontSize: 32, fontWeight: FontWeight.bold),
    headlineSmall: GoogleFonts.nunito(
        color: appBlack, fontSize: 20, fontWeight: FontWeight.bold),
    titleLarge: GoogleFonts.nunito(
        color: appBlack, fontSize: 24, fontWeight: FontWeight.bold),
    titleMedium: GoogleFonts.nunito(
        color: appWhite, fontSize: 20, fontWeight: FontWeight.bold),
    titleSmall: GoogleFonts.nunito(
        color: appBlack, fontSize: 16, fontWeight: FontWeight.bold),
    labelLarge: GoogleFonts.nunito(color: appWhite, fontSize: 16),
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
  primaryColor: primaryColor,
  colorScheme: ColorScheme(
    brightness: Brightness.dark, 
    primary: primaryColor, 
    onPrimary: appWhite, 
    secondary: secondaryColor, 
    onSecondary: appBlack, 
    error: Colors.red, 
    onError: appBlack, 
    background: appWhite, 
    onBackground: appBlack,
    surface: appWhite,
    onSurface: appBlack
  ),
  textTheme: TextTheme(
    headlineLarge: GoogleFonts.nunito(
        color: appWhite, fontSize: 44, fontWeight: FontWeight.bold),
    headlineMedium: GoogleFonts.nunito(
        color: appWhite, fontSize: 32, fontWeight: FontWeight.bold),
    headlineSmall: GoogleFonts.nunito(
        color: appWhite, fontSize: 20, fontWeight: FontWeight.bold),
    titleLarge: GoogleFonts.nunito(
        color: appWhite, fontSize: 24, fontWeight: FontWeight.bold),
    titleMedium: GoogleFonts.nunito(
        color: appBlack, fontSize: 20, fontWeight: FontWeight.bold),
    titleSmall: GoogleFonts.nunito(
        color: appWhite, fontSize: 16, fontWeight: FontWeight.bold),
    labelLarge: GoogleFonts.nunito(color: appBlack, fontSize: 16),
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
