import 'FamilyDTO.dart';

class VisitDTO {
  VisitDTO({required this.id, required this.family, required this.timestamp});

  final String id;
  final FamilyDTO family;
  String timestamp;

  factory VisitDTO.fromJson(Map<String, dynamic> json) => VisitDTO(
      id: json["id"].toString(),
      family: FamilyDTO.fromJson(json["familia"]),
      timestamp: json["dataHora"]);
}
