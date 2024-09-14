import 'PersonDTO.dart';

class NoticeDTO {
  NoticeDTO(
      {required this.id,
      required this.noticia,
      required this.agent,
      required this.timestamp});

  final String id;
  final String noticia;
  final PersonDTO agent;
  String timestamp;

  factory NoticeDTO.fromJson(Map<String, dynamic> json) => NoticeDTO(
      id: json["id"].toString(),
      noticia: json["noticia"].toString(),
      agent: PersonDTO.fromJson(json["agente"]),
      timestamp: json["dataHora"]);
}
