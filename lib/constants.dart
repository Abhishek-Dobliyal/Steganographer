import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

const kPrimaryColor = Color(0xFF1f0f4d);
const kAccentColor = Colors.amber;
const kScaffoldColor = Color(0xFF04052e);
const kFontFamily = 'Itim';
const kBottomBarIconColor = Colors.white;
final kBottomBarIconSize = 22.0;
final kSelectedIconSize = 8.0.w;
final kSelectedIconLabel = 5.0.w;
final kUnselectedIconLabel = 3.0.w;
final kActionButtonContainerSide = 15.0.h;

const kAppBarTheme = AppBarTheme(
  color: kPrimaryColor,
  centerTitle: true,
);

final kBottomBarTheme = BottomNavigationBarThemeData(
  backgroundColor: kPrimaryColor,
  selectedItemColor: Colors.amber,
  selectedIconTheme: IconThemeData(
    size: kSelectedIconSize,
  ),
  unselectedIconTheme: IconThemeData(
    color: kBottomBarIconColor,
    size: kBottomBarIconSize,
  ),
  selectedLabelStyle: TextStyle(
    fontFamily: kFontFamily,
    fontSize: kSelectedIconLabel,
  ),
  unselectedLabelStyle: TextStyle(
    fontFamily: kFontFamily,
    fontSize: kUnselectedIconLabel,
    color: kBottomBarIconColor,
  ),
  type: BottomNavigationBarType.fixed,
);
