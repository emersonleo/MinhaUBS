class PersonDTO {
  PersonDTO(
      {required this.id,
      required this.nome,
      // required this.fone,
      required this.cpf});

  final String id;
  final String nome;
  // final String fone;
  final String cpf;

  factory PersonDTO.fromJson(Map<String, dynamic> json) =>
      PersonDTO(id: json["id"], nome: json["nome"], cpf: json["cpf"]);
}
