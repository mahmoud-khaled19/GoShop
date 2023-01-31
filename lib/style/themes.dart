import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/style/colors.dart';

ThemeData lightMode = ThemeData(
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: HexColor('#F2F3F4'),
        elevation: 0,
        showUnselectedLabels: false,
        selectedItemColor: Colors.black,
        unselectedIconTheme: const IconThemeData(
          size: 18
        ),
        unselectedItemColor: Colors.grey[600],
        selectedLabelStyle:
            const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyText1: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
      bodyText2: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    ),
    scaffoldBackgroundColor: HexColor('#F2F3F4'),
    appBarTheme: AppBarTheme(
        iconTheme:  const IconThemeData(color: Colors.black, size: 25),
        systemOverlayStyle:  SystemUiOverlayStyle(
            statusBarColor:HexColor('#F2F3F4'),
            statusBarIconBrightness: Brightness.dark),
        backgroundColor: HexColor('#F2F3F4'),
        elevation: 0,
        titleTextStyle:const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold)),

    );
ThemeData darkMode = ThemeData(
    drawerTheme: DrawerThemeData(
      backgroundColor: darkPrimaryColor,
    ),
    textTheme: const TextTheme(
        bodyText1: TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
        bodyText2: TextStyle(
            fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
        headline1: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange)),
    scaffoldBackgroundColor: darkPrimaryColor,
    appBarTheme: AppBarTheme(
        titleSpacing: 18,
        iconTheme: const IconThemeData(color: Colors.white, size: 25),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: darkPrimaryColor,
            statusBarIconBrightness: Brightness.light),
        backgroundColor: darkPrimaryColor,
        elevation: 0,
        titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: darkPrimaryColor,
        elevation: 0,
        showUnselectedLabels: false,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.white,
        selectedLabelStyle:
            const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
    primarySwatch: Colors.blue);
