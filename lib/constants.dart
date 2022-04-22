import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';

Color mainLight = const Color(0xFFF50057);
Color mainDark = const Color(0xFFD0004A);

NeumorphicThemeData lightTheme = const NeumorphicThemeData(
    baseColor: Colors.white,
    lightSource: LightSource.topLeft,
    depth: 8);

NeumorphicThemeData darkTheme = NeumorphicThemeData(
    baseColor: Colors.grey.shade900,
    lightSource: LightSource.bottomRight,
    depth: 4);

Color textColor(BuildContext context) {
  if (NeumorphicTheme.isUsingDark(context)) {
    return Colors.white;
  } else {
    return Colors.black;
  }
}

TextStyle themedStyle({required bool invert, double size = 18, FontWeight weight = FontWeight.normal, Color? color}) {
  Color textColor = color ?? (invert ? Colors.grey.shade900 : Colors.white);
  return GoogleFonts.dosis(fontSize: size, fontWeight: weight, color: textColor);
}

class BottomRoundedCorners extends NeumorphicPathProvider {
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
}
