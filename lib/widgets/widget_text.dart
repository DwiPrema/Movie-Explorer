import 'package:flutter/material.dart';
import 'package:movie_omdbid_api/core/constant/colors.dart';

Widget title(String text, {TextAlign align = TextAlign.center, Color color = AppColors.white, double fontSize = 24, FontWeight fontWeight = FontWeight.w400}) {
  return Text(
      text,
      textAlign: align,
      style: TextStyle( 
        fontFamily: 'RacingSansOne',
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight
      ),
    );
}

Widget subtitle(String text, {TextAlign align = TextAlign.center, Color color = AppColors.grey, double fontSize = 16, FontWeight fontWeight = FontWeight.w400, FontStyle fontStyle = FontStyle.normal}) {
  return Text(
      text,
      textAlign: align,
      style: TextStyle(
        fontFamily: "RedHatDisplay",
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
      ),
    );
}