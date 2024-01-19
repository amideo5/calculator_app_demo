import 'package:flutter/material.dart';

Widget calcButton(
    String buttonText, Color buttonColor, void Function()? buttonPressed) {
  return Container(
    width: 75,
    height: buttonText == '=' ? 150 : 70,
    padding: const EdgeInsets.all(0),
    child: ElevatedButton(
      onPressed: buttonPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor),
      child: Text(
        buttonText,
        style: TextStyle(fontSize: (buttonText == 'AC' || buttonText == '+/-') ? 20 : 27, color: Color.fromARGB(255, 255, 255, 255)),
      ),
    ),
  );
}