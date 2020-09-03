import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';

class StoryTextStyles {
  static final styles = [
    _roboto,
    _ruluko,
    _comforta,
    _merriweather,
    _lobster,
    _patrikHand
  ];

  static final TextStyle _roboto = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontFamily: GoogleFonts.roboto().fontFamily,
  );

  static final TextStyle _ruluko = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontFamily: GoogleFonts.ruluko().fontFamily,
  );

  static final TextStyle _comforta = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontFamily: GoogleFonts.comfortaa().fontFamily,
  );

  static final TextStyle _merriweather = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontFamily: GoogleFonts.merriweather().fontFamily,
  );

  static final TextStyle _lobster = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontFamily: GoogleFonts.lobster().fontFamily,
  );

  static final TextStyle _patrikHand = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontFamily: GoogleFonts.patrickHand().fontFamily,
  );
}
