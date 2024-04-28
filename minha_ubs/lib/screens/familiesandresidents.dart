import 'package:flutter/material.dart';

class FamiliesAndResidents extends StatefulWidget {
  const FamiliesAndResidents({super.key});

  @override
  State<FamiliesAndResidents> createState() => _FamiliesAndResidentsState();
}

class _FamiliesAndResidentsState extends State<FamiliesAndResidents> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("Familias e Moradores"),
    );
  }
}
