class CaseDTO {
  CaseDTO({required this.id, required this.latitude, required this.longitude});

  final String id;
  final String latitude;
  final String longitude;

  factory CaseDTO.fromJson(Map<String, dynamic> json) => CaseDTO(
        id: json["id"].toString(),
        latitude: json["latitude"],
        longitude: json["longitude"],
      );
}
