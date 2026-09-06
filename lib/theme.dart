import 'package:flutter/material.dart';

const semilla= Color(0xFF0D47A1);

final appTheme= ThemeData(
  
  colorScheme: ColorScheme.fromSeed(seedColor: semilla),

  appBarTheme: AppBarThemeData(
    centerTitle: true,
    elevation: 0,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
  ),
  cardTheme: CardThemeData(
    elevation: 0,
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10)
    ),
  chipTheme: ChipThemeData(
    elevation: 0,
    showCheckmark: false, side: BorderSide.none,
  ),

  listTileTheme: ListTileThemeData(
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    horizontalTitleGap: 10,
    minVerticalPadding: 0,
    dense: true,

  ),

);