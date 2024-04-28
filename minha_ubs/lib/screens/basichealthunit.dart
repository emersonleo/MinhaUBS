import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minha_ubs/screens/familiesandresidents.dart';
import 'package:minha_ubs/screens/mainscreen.dart';
import 'package:minha_ubs/screens/ubsnews.dart';

import '../components/ButtonBuilder.dart';

class BasicHealthUnit extends StatefulWidget {
  const BasicHealthUnit({super.key});

  @override
  State<BasicHealthUnit> createState() => _BasicHealthUnitState();
}

class _BasicHealthUnitState extends State<BasicHealthUnit> {
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
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 7),
                      child: IconButton(
                          color: const Color(0xFF00A038),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainScreen()),
                            );
                          },
                          icon: const Icon(Icons.arrow_back)),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Center(
                                child: Text(
                                  "PSF PEDREIRA MANGUEIRA",
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
                            children: [
                              Center(
                                child: Text(
                                  "R André Vidal Negreiros, 324 - Mangueira",
                                  style: GoogleFonts.montserrat(
                                    color: const Color(0xFF5C5C5C),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ButtonBuilder.getOutlinedButton("Notícias do Posto",
                        Icons.notifications_active_outlined, () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UBSNews()),
                      );
                    }),
                    ButtonBuilder.getOutlinedButton(
                        "Famílias e Moradores", Icons.group_outlined, () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FamiliesAndResidents()),
                      );
                    }),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
