import 'package:flutter/material.dart'
    show
        AppBarTheme,
        Color,
        Colors,
        FontWeight,
        IconThemeData,
        TextStyle,
        TextTheme,
        ThemeData;
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Colors.green;
  static const Color backgroundColor = Color(0xffF2F2F2);
  static const Color textColor = Color(0xff25282B);
  static const Color errorColor = Color(0xffCF212A);
  static const Color orange = Color(0xffFF696A);

  static final TextStyle appBarTextStyle = TextStyle(
      color: AppTheme.textColor, fontSize: 20.0, fontWeight: FontWeight.bold);

  static final flatButtonTheme = TextStyle(
    color: AppTheme.orange,
    fontSize: 16.0,
    fontWeight: FontWeight.w700,
  );

  static ThemeData getTheme() {
    return ThemeData(
      fontFamily: GoogleFonts
          .openSans()
          .fontFamily,
      backgroundColor: AppTheme.backgroundColor,
      primarySwatch: Colors.green,
      accentColor: AppTheme.orange,
      appBarTheme: AppBarTheme(
        color: AppTheme.backgroundColor,
        elevation: 0.0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: AppTheme.textColor,
        ),
        textTheme: TextTheme(caption: AppTheme.appBarTextStyle),
      ),
    );
  }
}
