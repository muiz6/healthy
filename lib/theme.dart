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
  cardTheme: CardTheme(
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(dimens.radiusM),
    ),
  ),
  appBarTheme: AppBarTheme(
    centerTitle: true,
    backgroundColor: Colors.transparent,
    elevation: 0,
    titleTextStyle: _textTheme.headline3?.copyWith(
      color: _colorScheme.onBackground,
    ),
    foregroundColor: _colorScheme.onBackground,
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
  headline4: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  ),
);
