class PersonDTO {
  PersonDTO(
      {required this.id,
      required this.nome,
      required this.fone,
      required this.cpf});

  final int id;
  final String nome;
  final String fone;
  final String cpf;

  factory PersonDTO.fromJson(Map<String, dynamic> json) => PersonDTO(
      id: json["id"], nome: json["nome"], fone: json["fone"], cpf: json["cpf"]);
}
