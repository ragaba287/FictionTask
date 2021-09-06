import 'package:ahmed_ragab/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: accentColor,
  accentColor: accentColor,
  fontFamily: 'exo2',
  scaffoldBackgroundColor: Colors.white,
  brightness: Brightness.light,
  iconTheme: IconThemeData(color: Colors.black, size: 20.w),
  appBarTheme: AppBarTheme(
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.black),
    backgroundColor: Colors.transparent,
    elevation: 0,
    titleTextStyle: TextStyle(color: Colors.black),
    centerTitle: true,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.transparent,
    elevation: 0,
    selectedIconTheme: IconThemeData(color: accentColor),
    unselectedIconTheme: IconThemeData(color: Colors.grey),
    showUnselectedLabels: false,
    selectedItemColor: accentColor,
  ),
  cardColor: Colors.white,
  shadowColor: Colors.grey[200]!,
  textTheme: TextTheme(
    subtitle1: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 18.sp,
    ),
    subtitle2: TextStyle(
      height: 1.3,
      fontSize: 14.sp,
    ),
    headline5: TextStyle(
      height: 1.3,
      fontWeight: FontWeight.w600,
    ),
    headline6: TextStyle(
      height: 1.3,
      fontWeight: FontWeight.w600,
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  primaryColor: accentColor,
  accentColor: accentColor,
  fontFamily: 'exo2',
  scaffoldBackgroundColor: Color(0xff181920),
  brightness: Brightness.dark,
  iconTheme: IconThemeData(color: Colors.white, size: 20.w),
  appBarTheme: AppBarTheme(
    brightness: Brightness.dark,
    iconTheme: IconThemeData(color: Colors.white),
    backgroundColor: Colors.transparent,
    elevation: 0,
    titleTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
    centerTitle: true,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.transparent,
    elevation: 0,
    selectedIconTheme: IconThemeData(color: accentColor),
    unselectedIconTheme: IconThemeData(color: Colors.grey),
    showUnselectedLabels: false,
    selectedItemColor: accentColor,
  ),
  cardColor: Color(0xff252A34),
  shadowColor: Colors.black12,
  textTheme: TextTheme(
    subtitle1: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 18.sp,
      color: Colors.white,
    ),
    subtitle2: TextStyle(
      height: 1.3,
      fontSize: 14.sp,
      color: Colors.white70,
    ),
    headline5: TextStyle(
      height: 1.3,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    headline6: TextStyle(
      height: 1.3,
      fontWeight: FontWeight.w600,
    ),
  ),
);
