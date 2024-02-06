import 'package:flutter/material.dart';

class TextFieldBuilder {
  TextEditingController controller = TextEditingController();
  bool obscureText = true;
  String? labelText;
  IconData? icon;
  State? state;

  TextFieldBuilder(
      String labelTextParam, IconData iconParam, State stateParam) {
    labelText = labelTextParam;
    icon = iconParam;
    state = stateParam;
  }

  Padding getTextfield() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          focusedBorder: const OutlineInputBorder(),
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }

  Padding getTextfieldWithSufix() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
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
