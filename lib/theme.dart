import 'package:flutter/material.dart';

import 'package:healthy/dimens.dart' as dimens;

final appTheme = ThemeData.from(
  colorScheme: _colorScheme,
  textTheme: _textTheme,
).copyWith(
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all(EdgeInsets.all(dimens.insetM)),
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      )),
    ),
  ),
);

const _colorScheme = ColorScheme.light(
  primary: Color(0xff8883f0),
  secondary: Color(0xffef8481),
  background: Color(0xfff7fafe),
);

const _textTheme = TextTheme(
  headline3: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  ),
);
