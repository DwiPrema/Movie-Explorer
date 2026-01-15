import 'package:flutter/material.dart';

Widget title(String text, {TextAlign align = TextAlign.center, Color color = Colors.black, double fontSize = 20, FontWeight fontWeight = FontWeight.bold}) {
  return Align(
    child: Text(
      text,
      textAlign: align,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    ),
  );
}

Widget subtitle(String text, {TextAlign align = TextAlign.center, Color color = Colors.grey, double fontSize = 16, FontWeight fontWeight = FontWeight.w400}) {
  return Align(
    child: Text(
      text,
      textAlign: align,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    ),
  );
}