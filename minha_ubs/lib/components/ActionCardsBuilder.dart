import 'package:flutter/material.dart';

class ActionCardsBuilder {
  static List<PopupMenuItem<String>> getPopupItems(List<String> menuItems) {
    List<PopupMenuItem<String>> itemsReturn = [];
    for (var popupText in menuItems) {
      itemsReturn.add(PopupMenuItem(
        value: popupText,
        child: Text(popupText),
      ));
    }

    return itemsReturn;
  }
}

// PopupMenuItem(
// value: 'Editar',
// child: Text('Editar'),
// ),
