import 'package:minha_ubs/DTOs/PersonDTO.dart';

class UserDTO {
  UserDTO(
      {required this.id,
      required this.email,
      required this.senha,
      required this.pessoa});

  final int id;
  final String email;
  final String senha;
  final PersonDTO pessoa;

  factory UserDTO.fromJson(Map<String, dynamic> json) => UserDTO(
      id: json["id"],
      email: json["email"],
      senha: json["senha"],
      pessoa: PersonDTO.fromJson(json["pessoa"]));
}
