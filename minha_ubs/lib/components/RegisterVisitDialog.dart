import 'package:flutter/material.dart';
import 'package:minha_ubs/components/ButtonBuilder.dart';
import 'package:minha_ubs/components/TextBuilder.dart';

void registerVisitDialog(BuildContext context, String familyId, int agentId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: TextBuilder.getDialogTitle(
            "Confirma a Visita da Família Santos?", 20),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ButtonBuilder.getFilledButton(
                  "Registrar", () => null, 0xFF00A038),
              ButtonBuilder.getFilledButton(
                  "Cancelar", () => {Navigator.of(context).pop()}, 0xFF7A7A7A),
            ],
          ),
        ],
      );
    },
  );
}
