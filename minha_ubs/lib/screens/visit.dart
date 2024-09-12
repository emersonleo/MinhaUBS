import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:minha_ubs/components/ButtonBuilder.dart';
import 'package:minha_ubs/screens/mainscreen.dart';

import '../services/VisitService.dart';

class Visit extends StatefulWidget {
  const Visit({super.key});

  @override
  State<Visit> createState() => _VisitState();
}

class _VisitState extends State<Visit> {
  String? visitsCount = "0";
  Future<List<dynamic>> resultVisitsList = VisitService(Client()).getVisits(1);

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

  Future<List<dynamic>> visitList(
      [String? dateStart = "", String? dateEnd = ""]) async {
    return VisitService(Client()).getVisits(1, dateStart, dateEnd);
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
                                      builder: (context) => const MainScreen()),
                                );
                              },
                              icon: const Icon(Icons.arrow_back)),
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Center(
                            child: Text(
                              "Visitas",
                              style: GoogleFonts.montserrat(
                                color: const Color(0xFF5C5C5C),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
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
                                  "Filtrar",
                                  () => {
                                        setState(() {
                                          String dateStart = dateFormat
                                              .format(selectedDateStart!);
                                          String dateEnd = dateFormat
                                              .format(selectedDateEnd!);

                                          resultVisitsList =
                                              visitList(dateStart, dateEnd);
                                          resultVisitsList.then((value) => {
                                                visitsCount =
                                                    value.length.toString()
                                              });
                                        })
                                      },
                                  0xFF00A038)
                            ],
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Total de Visitas: $visitsCount',
                            style: GoogleFonts.roboto(
                              color: const Color(0xFF5C5C5C),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: FutureBuilder<List<dynamic>>(
                        future: resultVisitsList,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            print(snapshot.error);
                            return const Center(
                                child: Text(
                                    'Ocorreu um erro inesperado no carregamento dos dados'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                                child: Text(
                                    'Não foram encontrados dados de famílias ou moradores.'));
                          } else {
                            final List? visits = snapshot.data?.toList();
                            visitsCount = visits?.length.toString();
                            return ListView.builder(
                              itemCount: visits?.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(
                                        color: Colors.grey.withOpacity(0.5),
                                        width: 1.5),
                                  ),
                                  child: ListTile(
                                    title: Text(visits![index].family.nome),
                                    subtitle: Text(visits![index].timestamp),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    )
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
