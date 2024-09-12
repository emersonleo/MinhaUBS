class FamilyDTO {
  FamilyDTO({required this.id, required this.nome});

  final String id;
  final String nome;

  factory FamilyDTO.fromJson(Map<String, dynamic> json) =>
      FamilyDTO(id: json["id"].toString(), nome: json["nome"]);
}
