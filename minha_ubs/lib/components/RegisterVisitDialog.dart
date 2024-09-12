import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:minha_ubs/components/ButtonBuilder.dart';
import 'package:minha_ubs/components/TextBuilder.dart';

import '../services/VisitService.dart';

class RegisterVisitDialog extends StatefulWidget {
  final String idFamily;
  final String idAgent;
  final String idBHU;
  final String nameFamily;

  const RegisterVisitDialog(
      {super.key,
      required this.idFamily,
      required this.idAgent,
      required this.idBHU,
      required this.nameFamily});

  @override
  State<RegisterVisitDialog> createState() => _RegisterVisitDialogState();
}

class _RegisterVisitDialogState extends State<RegisterVisitDialog> {
  VisitService visitService = VisitService(Client());

  Future<void> createVisit() async {
    visitService.registerVist(widget.idBHU, widget.idAgent, widget.idFamily);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    String name = widget.nameFamily;
    return AlertDialog(
      title: TextBuilder.getDialogTitle("Confirma a Visita da $name ?", 20),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ButtonBuilder.getFilledButton(
                "Registrar", () => {createVisit()}, 0xFF00A038),
            ButtonBuilder.getFilledButton(
                "Cancelar", () => {Navigator.of(context).pop()}, 0xFF7A7A7A),
          ],
        ),
      ],
    );
    ;
  }
}
