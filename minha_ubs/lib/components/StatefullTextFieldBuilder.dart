import 'package:flutter/material.dart';

class StatefullTextFieldBuilder extends StatefulWidget {
  //const StatefullTextFieldBuilder({super.key});
  TextEditingController? controller;
  String? labelText;
  IconData? icon;

  StatefullTextFieldBuilder(String labelTextParam, IconData iconParam,
      TextEditingController controllerParam,
      {super.key}) {
    labelText = labelTextParam;
    icon = iconParam;
    controller = controllerParam;
  }

  @override
  State<StatefullTextFieldBuilder> createState() =>
      _StatefullTextFieldBuilderState(labelText, icon, controller);
}

class _StatefullTextFieldBuilderState extends State<StatefullTextFieldBuilder> {
  TextEditingController editingController = new TextEditingController();
  String? labelText;
  IconData? icon;
  bool obscureText = true;
  TextEditingController? controller;

  _StatefullTextFieldBuilderState(
      String? labelTextParam, IconData? iconParam, controllerParam) {
    labelText = labelTextParam;
    icon = iconParam;
    controller = controllerParam;
  }

  @override
  Widget build(BuildContext context) {
    // String? newLabelText = labelText;
    // IconData? newIccon = icon;
    //bool obscureText = true;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          labelText: labelText,
          focusedBorder: const OutlineInputBorder(),
          prefixIcon: Icon(icon),
          suffixIcon: IconButton(
            icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
          ),
        ),
      ),
    );
  }
}
