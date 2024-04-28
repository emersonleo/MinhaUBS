import 'package:flutter/material.dart';

class UBSNews extends StatefulWidget {
  const UBSNews({super.key});

  @override
  State<UBSNews> createState() => _UBSNewsState();
}

class _UBSNewsState extends State<UBSNews> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("Noticias do Posto"),
    );
    ;
  }
}
