import 'dart:convert';

import 'package:http/http.dart' as http;

import '../DTOs/FamilyDTO.dart';
import '../DTOs/PersonDTO.dart';
import '../utils/constants.dart';

class BHUService {
  final http.Client httpClient;

  BHUService(this.httpClient);

  Future<List<PersonDTO>> getBHUResidents(int BHUId) async {
    String url =
        "${Constants.ENVIRONMENT_HOST}${Constants.RESIDENT_BHU_PATH}${BHUId}";
    Map<String, String> headers = {"content-type": "application/json"};
    http.Response response =
        await httpClient.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      String responseBody = utf8.decode(response.bodyBytes);
      List<dynamic> persons = jsonDecode(responseBody);
      List<PersonDTO> personDTOs = persons.map((person) {
        return PersonDTO.fromJson(person);
      }).toList();
      return personDTOs;
    }
    return [];
  }

  Future<List<FamilyDTO>> getBHUFamilies(int BHUId) async {
    String url =
        "${Constants.ENVIRONMENT_HOST}${Constants.FAMILY_BHU_PATH}${BHUId}";
    Map<String, String> headers = {
      "content-type": "application/json; charset=utf-8;"
    };
    http.Response response =
        await httpClient.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      String responseBody = utf8.decode(response.bodyBytes);
      List<dynamic> families = jsonDecode(responseBody);
      List<FamilyDTO> familiesDTOs = families.map((family) {
        return FamilyDTO.fromJson(family);
      }).toList();
      return familiesDTOs;
    }
    return [];
  }
}
