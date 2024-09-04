import 'package:flutter/material.dart';

class AppColors {
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color trans = Colors.transparent;
  static const Color red = Colors.red;
  static const Color primary = Color(0xFF002E94);
  static const Color lightBlack = Color(0xFF222222);
  static const Color darkPrimary = Color(0xFF04256F);
  static const Color secondary = Color(0xFFFFB200);
  static const Color tertiaryOrange = Color(0xFFFC6404);
  static const Color hintColor = Color(0xFF6B7280);
  static const Color grey = Color(0xFF4B5563);
  static const Color grey400 = Color(0xFF9CA3AF);
  static const Color grey100 = Color(0xFFF3F4F6);
  static const Color grey300 = Color(0xFFD1D5DB);
  static const Color greyLight = Color(0xFFE5E7EB);
  static const Color green = Color(0xFF059669);
  static const Color yellow100 = Color(0xFFFEF3C7);
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      primary, // Start color
      darkPrimary, // End color
    ],
    begin: Alignment.centerLeft, // Gradient direction
    end: Alignment.centerRight,
  );
  static const LinearGradient welcomeGradient = LinearGradient(
    colors: [
      Color(0xffFFD880),
      Color(0xffD09203),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [
      secondary,
      tertiaryOrange,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  }