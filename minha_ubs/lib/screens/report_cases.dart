import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:minha_ubs/screens/report_heatmap.dart';

import '../components/ButtonBuilder.dart';
import 'basichealthunit.dart';

class ReportCases extends StatefulWidget {
  const ReportCases({super.key});

  @override
  State<ReportCases> createState() => _ReportHeatmapState();
}

class _ReportHeatmapState extends State<ReportCases> {
  DateTime? selectedDateStart = DateTime.now();
  DateTime? selectedDateEnd = DateTime.now();

  final DateFormat dateFormat = DateFormat('dd/MM/yyyy');

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate
          ? (selectedDateStart ?? DateTime.now())
          : (selectedDateEnd ?? DateTime.now()),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (isStartDate && picked!.isAfter(selectedDateEnd!)) {
      return;
    } else if (!isStartDate && picked!.isBefore(selectedDateStart!)) {
      return;
    }

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          selectedDateStart = picked;
        } else {
          selectedDateEnd = picked;
        }
      });
    }
  }

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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Data Inicial",
                                style: GoogleFonts.roboto(
                                  color: const Color(0xFF5C5C5C),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 0.0),
                                child: ElevatedButton(
                                  onPressed: () => _selectDate(context, true),
                                  child: Text(
                                    selectedDateStart != null
                                        ? dateFormat.format(selectedDateStart!)
                                        : "Escolha a data inicial",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Data Final",
                                style: GoogleFonts.roboto(
                                  color: const Color(0xFF5C5C5C),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 0.0),
                                child: ElevatedButton(
                                  onPressed: () => _selectDate(context, false),
                                  child: Text(
                                    selectedDateEnd != null
                                        ? dateFormat.format(selectedDateEnd!)
                                        : "Escolha a data final",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ButtonBuilder.getFilledButton(
                                  "Gerar Relatório",
                                  () => {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ReportHeatmap()),
                                        )
                                      },
                                  0xFF00A038)
                            ],
                          )
                        ],
                      ),
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
