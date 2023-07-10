import 'package:flutter/material.dart';

class Utils {
  static bool isOperator(String buttonText, {bool hasEquals = false}) {
    final operators = [
      '+',
      '-',
      '/',
      '*',
      '.',
      if (hasEquals) ...['=']
    ];

    return operators.contains(buttonText);
  }
}

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(text)),
  );
}
