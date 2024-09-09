import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:minha_ubs/components/ActionCardsBuilder.dart';
import 'package:minha_ubs/components/RegisterCaseDialog.dart';
import 'package:minha_ubs/components/RegisterVisitDialog.dart';
import 'package:minha_ubs/screens/basichealthunit.dart';
import 'package:minha_ubs/services/BHUService.dart';
import 'package:minha_ubs/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../DTOs/FamilyDTO.dart';
import '../DTOs/PersonDTO.dart';
import '../DTOs/UserDTO.dart';
import '../components/TextBuilder.dart';

class FamiliesAndResidents extends StatefulWidget {
  const FamiliesAndResidents({super.key});

  @override
  State<FamiliesAndResidents> createState() => _FamiliesAndResidentsState();
}

enum TypeListFamilyResident { family, resident }

class _FamiliesAndResidentsState extends State<FamiliesAndResidents> {
  TextEditingController controllerSearch = TextEditingController();
  TypeListFamilyResident? typeList = TypeListFamilyResident.family;
  Future<List<FamilyDTO>> families = BHUService(Client()).getBHUFamilies(1);
  Future<List<PersonDTO>> residents = BHUService(Client()).getBHUResidents(1);

  Future<List<dynamic>> listaCards({String? searchValue}) async {
    Future<List<dynamic>> resultList =
        typeList == TypeListFamilyResident.family ? families : residents;
    return resultList;
  }

  @override
  Widget build(BuildContext context) {
    TextBuilder titleTextFamilyResidents = TextBuilder("Famílias e Moradores");

    List<String> menuResident = [
      Constants.registerCaseOption,
      Constants.sendMessageOption
    ];
    List<String> menuFamily = [
      Constants.registerVisitOption,
      Constants.viewResidentsOption
    ];

    String? userAuthenticated;
    final prefs = SharedPreferences.getInstance()
        .then((value) => {userAuthenticated = value.getString("user")});

    return Scaffold(
      body: Container(
        color: const Color(0xFFF5F5F5),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 26),
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
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "Famílias e Moradores",
                            style: GoogleFonts.montserrat(
                              color: const Color(0xFF5C5C5C),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
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
                                controllerSearch.clear();
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<TypeListFamilyResident>(
                            title: const FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text('Moradores')),
                            value: TypeListFamilyResident.resident,
                            groupValue: typeList,
                            onChanged: (TypeListFamilyResident? value) {
                              setState(() {
                                typeList = value;
                                controllerSearch.clear();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 16),
                            child: TextField(
                              keyboardType: TextInputType.text,
                              controller: controllerSearch,
                              onChanged: (text) {
                                listaCards(searchValue: text);
                                setState(() {});
                              },
                              decoration: const InputDecoration(
                                labelText: "Buscar família ou morador",
                                focusedBorder: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.search),
                              ),
                            ),
                          ),
                        ),
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
                            var filteredItems = snapshot.data!.where((item) {
                              return item.nome.contains(controllerSearch.text);
                            }).toList();
                            final List<dynamic> persons = filteredItems;
                            return ListView.builder(
                              itemCount: filteredItems?.length,
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
                                      onSelected: (value) async {
                                        switch (value) {
                                          case Constants.registerCaseOption:
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    RegisterCaseDialog(
                                                      idPerson:
                                                          persons![index].id,
                                                      userAuthenticated:
                                                          userAuthenticated,
                                                    ));
                                            break;
                                          case Constants.sendMessageOption:
                                            //registerCaseDialog(context);
                                            break;
                                          case Constants.registerVisitOption:
                                            String familyId =
                                                persons![index].id;
                                            int agentId = UserDTO.fromJson(
                                                    jsonDecode(
                                                        userAuthenticated!))!
                                                .id;
                                            registerVisitDialog(
                                                context, familyId, agentId);
                                            break;
                                          case Constants.viewResidentsOption:
                                            //registerCaseDialog(context);
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
