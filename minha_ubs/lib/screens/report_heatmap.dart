import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_heatmap/flutter_map_heatmap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:latlong2/latlong.dart';
import 'package:minha_ubs/DTOs/CaseDTO.dart';
import 'package:minha_ubs/screens/report_cases.dart';
import 'package:minha_ubs/services/CaseService.dart';

class ReportHeatmap extends StatefulWidget {
  const ReportHeatmap({super.key});

  @override
  State<ReportHeatmap> createState() => _ReportCasesState();
}

class _ReportCasesState extends State<ReportHeatmap> {
  CaseService caseService = CaseService(Client());

  Future<List<WeightedLatLng>> getCoordinates() async {
    Future<List<CaseDTO>> cases = CaseService(Client())
        .listCases("1", "11", "3", "17/08/2024", "20/09/2024");

    List<WeightedLatLng> casesRegistered = [];
    List<CaseDTO> casesDTOList = [];
    await cases.then((listCases) => {casesDTOList = listCases.toList()});

    casesDTOList.forEach((caseRegistered) => casesRegistered.add(WeightedLatLng(
        LatLng(double.parse(caseRegistered.latitude),
            double.parse(caseRegistered.longitude)),
        1)));
    return casesRegistered;
  }

  final List<WeightedLatLng> coordinatesCases = [];

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
                                          const ReportCases()),
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
                    FutureBuilder(
                        future: getCoordinates(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator(); // Exibe um loader enquanto espera
                          } else if (snapshot.hasError) {
                            return Text('Erro: ${snapshot.error}');
                          } else {
                            return Expanded(
                              child: FlutterMap(
                                options: const MapOptions(
                                    initialCenter: LatLng(-8.11777, -35.0931),
                                    initialZoom: 15.0),
                                children: [
                                  TileLayer(
                                      urlTemplate:
                                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                      subdomains: ['a', 'b', 'c']),
                                  if (snapshot.data!.isNotEmpty)
                                    HeatMapLayer(
                                      heatMapDataSource:
                                          InMemoryHeatMapDataSource(
                                              data: snapshot.data!),
                                      heatMapOptions: HeatMapOptions(
                                          blurFactor: 1,
                                          layerOpacity: 0.6,
                                          radius: 40,
                                          gradient:
                                              HeatMapOptions.defaultGradient,
                                          minOpacity: 0.1),
                                    )
                                ],
                              ),
                            );
                          }
                        })
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
