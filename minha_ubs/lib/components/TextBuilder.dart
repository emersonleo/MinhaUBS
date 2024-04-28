import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
              color: const Color(0xFF666666),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  static Future<String> getName() async {
    final prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString("user");
    print(user);
    //UserDTO userName = UserDTO.fromJson(JsonDecoder(user));

    return "";
  }
}
