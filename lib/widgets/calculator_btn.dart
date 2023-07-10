import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../utils/utils.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  final VoidCallback onClickedLong;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
    required this.onClickedLong,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = getTextColor(text);
    final double fontSize = Utils.isOperator(text, hasEquals: true) ? 26 : 22;
    final style = TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
    );
    return Expanded(
      child: Container(
        height: double.infinity,
        margin: const EdgeInsets.all(6),
        child: ElevatedButton(
          onPressed: onClicked,
          onLongPress: onClickedLong,
          style: ElevatedButton.styleFrom(
            backgroundColor: MyColors.background3,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Text(text, style: style),
        ),
      ),
    );
  }

  Color getTextColor(String buttonText) {
    switch (buttonText) {
      case '+':
      case '-':
      case '*':
      case '÷':
      case '/':
      case '=':
        return MyColors.operators;
      case 'AC':
      case '<':
        return MyColors.delete;
      default:
        return MyColors.numbers;
    }
  }
}
