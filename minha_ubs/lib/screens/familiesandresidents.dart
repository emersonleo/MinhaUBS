import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:minha_ubs/components/ActionCardsBuilder.dart';
import 'package:minha_ubs/screens/basichealthunit.dart';
import 'package:minha_ubs/services/BHUService.dart';
import 'package:minha_ubs/utils/constants.dart';

import '../components/RegisterCaseDialog.dart';
import '../components/TextBuilder.dart';
import '../components/TextFieldBuilder.dart';

class FamiliesAndResidents extends StatefulWidget {
  const FamiliesAndResidents({super.key});

  @override
  State<FamiliesAndResidents> createState() => _FamiliesAndResidentsState();
}

enum TypeListFamilyResident { family, resident }

class _FamiliesAndResidentsState extends State<FamiliesAndResidents> {
  TextEditingController controllerSearch = TextEditingController();
  TypeListFamilyResident? typeList = TypeListFamilyResident.family;
  BHUService bhuService = BHUService(Client());

  Future<List<dynamic>> listaCards() {
    return typeList == TypeListFamilyResident.family
        ? bhuService.getBHUFamilies(1)
        : bhuService.getBHUResidents(1);
  }

  @override
  Widget build(BuildContext context) {
    TextBuilder titleTextFamilyResidents = TextBuilder("Famílias e Moradores");
    TextFieldBuilder familyResidentTextField = TextFieldBuilder(
        "Buscar família ou morador", Icons.search, this, controllerSearch);
    dynamic cardItens = bhuService.getBHUFamilies(1);
    List<String> menuResident = [
      Constants.registerCaseOption,
      Constants.sendMessageOption
    ];
    List<String> menuFamily = [
      Constants.registerCaseOption,
      Constants.registerVisitOption,
      Constants.viewResidentsOption
    ];

    return Scaffold(
      body: Container(
        color: const Color(0xFFF5F5F5),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 16),
          child: Center(
            child: Stack(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 7),
                          child: IconButton(
                              color: const Color(0xFF00A038),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const BasicHealthUnit()),
                                );
                              },
                              icon: const Icon(Icons.arrow_back)),
                        ),
                        titleTextFamilyResidents.getTitleText(),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<TypeListFamilyResident>(
                            title: const Text('Família'),
                            value: TypeListFamilyResident.family,
                            groupValue: typeList,
                            onChanged: (TypeListFamilyResident? value) {
                              setState(() {
                                typeList = value;
                                cardItens = bhuService.getBHUFamilies(1);
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<TypeListFamilyResident>(
                            title: const Text('Moradores'),
                            value: TypeListFamilyResident.resident,
                            groupValue: typeList,
                            onChanged: (TypeListFamilyResident? value) {
                              setState(() {
                                typeList = value;
                                cardItens = bhuService.getBHUResidents(1);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: familyResidentTextField.getTextfield()),
                      ],
                    ),
                    Expanded(
                      child: FutureBuilder<List<dynamic>>(
                        future: listaCards(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return const Center(
                                child: Text(
                                    'Ocorreu um erro inesperado no carregamento dos dados'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                                child: Text(
                                    'Não foram encontrados dados de famílias ou moradores.'));
                          } else {
                            final List<dynamic>? persons = snapshot!.data;
                            return ListView.builder(
                              itemCount: persons?.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(
                                        color: Colors.grey.withOpacity(0.5),
                                        width: 1.5),
                                  ),
                                  child: ListTile(
                                    title: Text(persons![index].nome),
                                    trailing: PopupMenuButton<String>(
                                      itemBuilder: (context) {
                                        if (typeList ==
                                            TypeListFamilyResident.family) {
                                          return ActionCardsBuilder
                                              .getPopupItems(menuFamily);
                                        } else if (typeList ==
                                            TypeListFamilyResident.resident) {
                                          return ActionCardsBuilder
                                              .getPopupItems(menuResident);
                                        }
                                        return [];
                                      },
                                      onSelected: (value) {
                                        switch (value) {
                                          case Constants.registerCaseOption:
                                            registerCaseDialog(context);
                                            break;
                                          case Constants.sendMessageOption:
                                            registerCaseDialog(context);
                                            break;
                                          case Constants.registerVisitOption:
                                            registerCaseDialog(context);
                                            break;
                                          case Constants.viewResidentsOption:
                                            registerCaseDialog(context);
                                            break;
                                        }
                                      },
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
