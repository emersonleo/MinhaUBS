import 'dart:convert';

import 'package:http/http.dart' as http;

import '../utils/constants.dart';

class UserService {
  final http.Client httpClient;

  UserService(this.httpClient);

  Future<String> signInRequest(Map userData) async {
    String url = "${Constants.ENVIRONMENT_HOST}${Constants.USER_PATH}cadastrar";
    Map<String, String> headers = {"content-type": "application/json"};
    http.Response response = await httpClient.post(Uri.parse(url),
        headers: headers, body: const JsonEncoder().convert(userData));
    if (response.statusCode == 200) {
      print(response.body);
      return response.body;
    } else {
      throw Exception("Erro ao obter os dados: ${response.statusCode}");
    }
  }

  Future<String> loginRequest(Map userData) async {
    String url = "${Constants.ENVIRONMENT_HOST}${Constants.USER_PATH}login";
    Map<String, String> headers = {"content-type": "application/json"};
    http.Response response = await httpClient.post(Uri.parse(url),
        headers: headers, body: const JsonEncoder().convert(userData));
    if (response.statusCode == 200) {
      print(response.body);
      return response.body;
    } else {
      throw Exception("Erro ao obter os dados: ${response.statusCode}");
    }
  }
}
