import 'package:flutter/material.dart';

class ButtonBuilder {
  static Padding getOutlinedButton(
      String labelText, IconData buttonIcon, Null Function() redirect) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          SizedBox(
            width: 200,
            height: 100,
            child: OutlinedButton(
              onPressed: redirect,
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Icon(buttonIcon, size: 50),
                  Text(labelText, style: const TextStyle(fontSize: 14)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static FilledButton getFilledButton(
      String labelText, Function() redirect, int colorButton) {
    return FilledButton(
      onPressed: redirect,
      style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Color(colorButton)),
      child: Column(
        children: <Widget>[
          Text(labelText, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
