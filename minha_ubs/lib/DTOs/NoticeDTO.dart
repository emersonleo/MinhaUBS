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
/*

{
  "id": 1,
  "noticia": "aaaaaaaaaa",
  "agente": {
    "id": 11,
    "nome": "Lindalva Lira",
    "fone": "81987654321",
    "cpf": "11234456789"
  },
  "posto": {
    "id": 1,
    "nome": "PSF Pedreira Mangueira",
    "endereco": {
      "id": 7,
      "pais": "Brasil",
      "uf": "PE",
      "cidade": "Moreno",
      "bairro": "Centro",
      "rua": "R. Floriano Peixoto",
      "numero": "37",
      "cep": "54800000",
      "complemento": "Tabelionato de Notas",
      "latitude": "-8.118141077574409",
      "longitude": "-35.101124520302456"
    }
  },
  "dataHora": "2024-09-05T23:19:52"
}

 */
