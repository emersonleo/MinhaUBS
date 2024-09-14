import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:minha_ubs/utils/utils.dart';

import '../DTOs/CaseDTO.dart';
import '../utils/constants.dart';

class CaseService {
  final http.Client httpClient;

  CaseService(this.httpClient);

  Future<String> registerCase(
      int BHUId, int agentId, int personId, int caseId) async {
    String bodyRegisterCase =
        Utils.buildRegisterCaseBody(BHUId, agentId, personId, caseId);
    String url = "${Constants.ENVIRONMENT_HOST}${Constants.REGISTER_CASE_PATH}";
    Map<String, String> headers = {"content-type": "application/json"};
    http.Response response = await httpClient.post(Uri.parse(url),
        headers: headers, body: bodyRegisterCase);
    if (response.statusCode == 201) {
      return response.body;
    } else {
      throw Exception("Erro ao obter os dados: ${response.statusCode}");
    }
  }

  Future<List<CaseDTO>> listCases(String BHUId, String agentId, String caseId,
      String startDate, String endDate) async {
    String bodyRegisterCase =
        Utils.buildListCaseBody(BHUId, agentId, caseId, startDate, endDate);

    String url = "${Constants.ENVIRONMENT_HOST}${Constants.LIST_CASE_PATH}";
    Map<String, String> headers = {"content-type": "application/json"};

    http.Response response = await httpClient.post(Uri.parse(url),
        headers: headers, body: bodyRegisterCase);

    if (response.statusCode == 200) {
      String responseBody = utf8.decode(response.bodyBytes);
      List<dynamic> cases = jsonDecode(responseBody);

      List<CaseDTO> casesDTOs = cases.map((caseRegistered) {
        CaseDTO caseDTO = CaseDTO.fromJson(caseRegistered);
        return caseDTO;
      }).toList();
      return casesDTOs;
    } else {
      throw Exception("Erro ao obter os dados: ${response.statusCode}");
    }
  }
}
