import 'package:flutter/material.dart';
import 'package:movie_omdbid_api/core/constant/colors.dart';

Widget title(String text, {TextAlign align = TextAlign.center, Color color = AppColors.white, double fontSize = 24, FontWeight fontWeight = FontWeight.w400}) {
  return Align(
    child: Text(
      text,
      textAlign: align,
      style: TextStyle( 
        fontFamily: 'RacingSansOne',
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight
      ),
    ),
  );
}

Widget subtitle(String text, {TextAlign align = TextAlign.center, Color color = AppColors.grey, double fontSize = 16, FontWeight fontWeight = FontWeight.w400}) {
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