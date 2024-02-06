import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextBuilder {
  String? text;

  TextBuilder(String textParam) {
    text = textParam;
  }

  Expanded getTitleText() {
    return Expanded(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            text.toString(),
            style: GoogleFonts.montserrat(
              color: const Color(0xFF00A038),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
