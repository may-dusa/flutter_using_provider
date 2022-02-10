import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyleProto {
  TextStyleProto(
      {required this.size,
      this.color = Colors.black,
      this.fontWeight = FontWeight.normal,
      this.letterSpacing = 0,
      this.height = 1.3});

  double size, letterSpacing, height;
  FontWeight fontWeight;
  Color color;
}

TextStyle fontFamily(TextStyleProto tsp) {
  return GoogleFonts.lato(
      color: tsp.color,
      fontSize: tsp.size,
      letterSpacing: tsp.letterSpacing,
      fontWeight: tsp.fontWeight,
      height: tsp.height);
}

// =============================================================================
//        TEXT THEMES
// =============================================================================

TextTheme typography = TextTheme(
    headline1: fontFamily(
      TextStyleProto(
          size: 28,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
          height: 1.5),
    ),
    headline2: fontFamily(
      TextStyleProto(
          size: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.5,
          height: 1.5),
    ),
    bodyText1: fontFamily(
      TextStyleProto(size: 16),
    ),
    bodyText2: fontFamily(TextStyleProto(
      size: 12,
    )),
    overline: fontFamily(TextStyleProto(
        size: 12, letterSpacing: 0, fontWeight: FontWeight.w500)));
