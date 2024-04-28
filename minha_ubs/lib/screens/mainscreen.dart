import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minha_ubs/components/ButtonBuilder.dart';
import 'package:minha_ubs/screens/basichealthunit.dart';
import 'package:minha_ubs/screens/visit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFF5F5F5),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Center(
              child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
                    child: IconButton(
                        color: const Color(0xFF00A038),
                        onPressed: () async {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()),
                          );
                          final prefs = await SharedPreferences.getInstance();
                          prefs.clear();
                        },
                        icon: const Icon(Icons.arrow_back)),
                  ),
                  Center(
                    child: Text(
                      "Olá Lindalva",
                      style: GoogleFonts.montserrat(
                        color: const Color(0xFF5C5C5C),
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ButtonBuilder.getOutlinedButton(
                      "Meu posto", Icons.local_hospital, () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BasicHealthUnit()),
                    );
                  }),
                  ButtonBuilder.getOutlinedButton("Visitas", Icons.house, () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Visit()),
                    );
                  }),
                ],
              )
            ],
          )),
        ),
      ),
    );
  }
}
