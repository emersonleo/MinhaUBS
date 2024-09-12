import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:minha_ubs/DTOs/VisitDTO.dart';

import '../utils/constants.dart';
import '../utils/utils.dart';

class VisitService {
  final http.Client httpClient;

  VisitService(this.httpClient);

  Future<List<VisitDTO>> getVisits(int BHUId,
      [String? dateStart = "", String? dateEnd = ""]) async {
    String url = "${Constants.ENVIRONMENT_HOST}${Constants.LIST_VISIT_PATH}";

    Map<String, String> visitData = {
      "posto": "$BHUId",
      "agente": "11",
      "dataInicio": "$dateStart",
      "dataFim": "$dateEnd"
    };

    Map<String, String> headers = {"content-type": "application/json"};
    http.Response response = await httpClient.post(Uri.parse(url),
        body: const JsonEncoder().convert(visitData), headers: headers);
    if (response.statusCode == 200) {
      String responseBody = utf8.decode(response.bodyBytes);
      List<dynamic> visits = jsonDecode(responseBody);

      List<VisitDTO> visitsDTOs = visits.map((visit) {
        VisitDTO visitReturned = VisitDTO.fromJson(visit);
        DateTime date = DateTime.parse(visitReturned.timestamp);
        String formattedDate =
            DateFormat("d 'de' MMMM 'às' HH:mm", "pt_BR").format(date);
        visitReturned.timestamp = formattedDate;
        return visitReturned;
      }).toList();
      return visitsDTOs;
    }
    return [];
  }

  Future<String> registerVist(
      String BHUId, String agentId, String familyId) async {
    String bodyRegisterCase = Utils.buildVisitBody(BHUId, agentId, familyId);
    String url = "${Constants.ENVIRONMENT_HOST}${Constants.CREATE_VISIT_PATH}";
    Map<String, String> headers = {"content-type": "application/json"};
    http.Response response = await httpClient.post(Uri.parse(url),
        headers: headers, body: bodyRegisterCase);
    if (response.statusCode == 201) {
      return response.body;
    } else {
      throw Exception("Erro ao obter os dados: ${response.statusCode}");
    }
  }
}
