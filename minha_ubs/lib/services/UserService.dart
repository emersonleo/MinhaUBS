import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:minha_ubs/DTOs/UserDTO.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<UserDTO> loginRequest(Map userData) async {
    String url = "${Constants.ENVIRONMENT_HOST}${Constants.USER_PATH}login";
    Map<String, String> headers = {"content-type": "application/json"};
    http.Response response = await httpClient.post(Uri.parse(url),
        headers: headers, body: const JsonEncoder().convert(userData));
    final prefs = await SharedPreferences.getInstance();
    if (response.statusCode == 200) {
      final UserDTO userAuthenticated =
          UserDTO.fromJson(jsonDecode(response.body));
      prefs.setString('user', response.body);
      return userAuthenticated;
    } else {
      prefs.clear();
      throw Exception("Erro ao obter os dados: ${response.statusCode}");
    }
  }
}
