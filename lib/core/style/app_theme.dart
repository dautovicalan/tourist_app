import 'package:flutter/material.dart';
import 'package:tourist_app/core/style/colors.dart';

final lightTheme = ThemeData(
  fontFamily: 'Montserrat',
  scaffoldBackgroundColor: backgroundColorLight,
  extensions: const [
    AppColors(
      text: textColorLight,
      background: backgroundColorLight,
      border: borderColorLight,
      error: errorColorLight,
      gradientBegin: gradientBeginColorLight,
      gradientEnd: gradientEndColorLight,
      cardText: cardTextColorLight,
    ),
  ],
);