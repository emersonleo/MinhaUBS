import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'basichealthunit.dart';

class ReportHeatmap extends StatefulWidget {
  const ReportHeatmap({super.key});

  @override
  State<ReportHeatmap> createState() => _ReportHeatmapState();
}

class _ReportHeatmapState extends State<ReportHeatmap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFF5F5F5),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 26),
          child: Center(
            child: Stack(
              children: [
                Column(
                  children: [
                    Row(
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
                                      builder: (context) =>
                                          const BasicHealthUnit()),
                                );
                              },
                              icon: const Icon(Icons.arrow_back)),
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "Relatório De Casos",
                            style: GoogleFonts.montserrat(
                              color: const Color(0xFF5C5C5C),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
