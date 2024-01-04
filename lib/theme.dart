import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final appTheme = ThemeData(
  textTheme: GoogleFonts.poppinsTextTheme().copyWith(
    bodySmall: GoogleFonts.openSans(
      color: const Color(0xFF040510),
      fontWeight: FontWeight.w600,
      fontSize: 14,
    ),
    bodyMedium: GoogleFonts.poppins(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w300,
    ),
    bodyLarge: GoogleFonts.openSans(
      color: Colors.grey,
      fontSize: 16,
      fontWeight: FontWeight.w300,
    ),
    displayMedium: GoogleFonts.poppins(
      color: const Color(0xFF040510),
      fontWeight: FontWeight.w600,
      fontSize: 24,
    ),
    displaySmall: GoogleFonts.poppins(
      color: const Color(0xFF878AF5),
      fontSize: 16,
    ),
    displayLarge: GoogleFonts.poppins(
      color: const Color(0xFF040510),
      fontWeight: FontWeight.bold,
      fontSize: 26,
    ),
  ),
  scaffoldBackgroundColor: const Color(0xFFe3e4f8),
  primaryColor: const Color(0xFF878AF5),
  highlightColor: const Color(0xFF666AF6),
);
