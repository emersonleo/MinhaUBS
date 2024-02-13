import 'package:flutter/material.dart';

class TextFieldBuilder {
  TextEditingController? controller;
  String? labelText;
  IconData? icon;
  State? state;

  TextFieldBuilder(String labelTextParam, IconData iconParam, State stateParam,
      TextEditingController controllerParam) {
    labelText = labelTextParam;
    icon = iconParam;
    state = stateParam;
    controller = controllerParam;
  }

  Padding getTextfield() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextField(
        keyboardType: TextInputType.text,
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          focusedBorder: const OutlineInputBorder(),
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }

  Padding getTextfieldWithSufix(bool obscureText) {
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
              state?.setState(() {
                obscureText = !obscureText;
              });
            },
          ),
        ),
      ),
    );
  }
}
