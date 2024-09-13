import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:minha_ubs/utils/utils.dart';

import '../DTOs/NoticeDTO.dart';
import '../utils/constants.dart';

class NoticeService {
  final http.Client httpClient;

  NoticeService(this.httpClient);

  Future<String> registerNotice(int BHUId, int agentId, String notice) async {
    String bodyRegisterNotice =
        Utils.buildRegisterNoticeBody(BHUId, agentId, notice);

    String url = "${Constants.ENVIRONMENT_HOST}${Constants.CREATE_NOTICE_PATH}";
    Map<String, String> headers = {"content-type": "application/json"};
    http.Response response = await httpClient.post(Uri.parse(url),
        headers: headers, body: bodyRegisterNotice);
    if (response.statusCode == 201) {
      return response.body;
    } else {
      throw Exception("Erro ao obter os dados: ${response.statusCode}");
    }
  }

  Future<List<NoticeDTO>> getNotices(int BHUId) async {
    String url = "${Constants.ENVIRONMENT_HOST}${Constants.LIST_NOTICE_PATH}";

    Map<String, String> noticeData = {"posto": "$BHUId"};

    Map<String, String> headers = {"content-type": "application/json"};
    http.Response response = await httpClient.post(Uri.parse(url),
        body: const JsonEncoder().convert(noticeData), headers: headers);
    if (response.statusCode == 200) {
      String responseBody = utf8.decode(response.bodyBytes);
      List<dynamic> notices = jsonDecode(responseBody);

      List<NoticeDTO> noticesDTOs = notices.map((notice) {
        NoticeDTO noticeReturned = NoticeDTO.fromJson(notice);
        DateTime date = DateTime.parse(noticeReturned.timestamp);
        String formattedDate =
            DateFormat("d 'de' MMMM 'às' HH:mm", "pt_BR").format(date);
        noticeReturned.timestamp = formattedDate;
        return noticeReturned;
      }).toList();
      return noticesDTOs;
    }
    return [];
  }
}
