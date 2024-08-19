import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:minha_ubs/services/CaseService.dart';

import '../utils/utils.dart';
import 'ButtonBuilder.dart';
import 'TextBuilder.dart';

class RegisterCaseDialog extends StatefulWidget {
  final String person;

  const RegisterCaseDialog({super.key, required this.person});

  @override
  State<RegisterCaseDialog> createState() => _RegisterCaseDialogState();
}

class _RegisterCaseDialogState extends State<RegisterCaseDialog> {
  String? selectedValueFirstRow;
  String? selectedValueSecondRow;

  List<String> observations = ["Sintomas de dengue", "Sintomas Gripais"];
  List<String> clinicalConditions = ["Obesidade", "Desnutrição"];
  List<String> chronicDiseases = ["Hipertensão", "Diabetes"];
  List<String> infoHealth = [
    "Observações",
    "Doenças Cronicas",
    "Condições Clínicas"
  ];
  List<String> filteredTypeInfoMenu = ["Selecione uma opção"];

  CaseService caseService = CaseService(Client());

  void registerCase() {
    int selectedCase = Utils.getCaseId(selectedValueSecondRow?.toUpperCase());
    if (selectedCase != 0) {
      caseService.registerCase(1, 11, int.parse(widget.person), selectedCase);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: TextBuilder.getDialogTitle(
            "Qual informação que você deseja adicionar?", 20),
      ),
      actions: <Widget>[
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          DropdownButton<String>(
            hint: Text("Selecione o tipo de informação de saúde"),
            value: selectedValueFirstRow,
            onChanged: (String? newValue) {
              setState(() {
                selectedValueFirstRow = newValue;
                switch (newValue) {
                  case "Observações":
                    filteredTypeInfoMenu = observations;
                    selectedValueSecondRow = filteredTypeInfoMenu[0];
                    break;
                  case "Doenças Cronicas":
                    filteredTypeInfoMenu = chronicDiseases;
                    selectedValueSecondRow = filteredTypeInfoMenu[0];
                    break;
                  case "Condições Clínicas":
                    filteredTypeInfoMenu = clinicalConditions;
                    selectedValueSecondRow = filteredTypeInfoMenu[0];
                    break;
                }
              });
            },
            items: infoHealth.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              hint: Text("Selecione a informação desejada"),
              value: selectedValueSecondRow,
              onChanged: (String? newValue) {
                setState(() {
                  selectedValueSecondRow = newValue;
                });
              },
              items: filteredTypeInfoMenu
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ButtonBuilder.getFilledButton(
                "Registrar", () => {registerCase()}, 0xFF00A038),
            ButtonBuilder.getFilledButton(
                "Cancelar", () => {Navigator.of(context).pop()}, 0xFF7A7A7A),
          ],
        ),
      ],
    );
  }
}
