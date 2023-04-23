import 'package:flutter/material.dart';
import 'package:shop_app/app_constance/style_manager.dart';
import 'package:shop_app/app_constance/values_manager.dart';
import 'colors_manager.dart';

ThemeData getLightApplicationTheme() {
  return ThemeData(
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: ColorsManager.lightScaffoldColor,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedIconTheme:
              IconThemeData(size: 30, color: ColorsManager.lightIPrimaryColor),
          unselectedIconTheme: const IconThemeData(size: 20),
          showSelectedLabels: false,
          showUnselectedLabels: false),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
        ColorsManager.lightIPrimaryColor,
      ))),
      appBarTheme: AppBarTheme(
          backgroundColor: ColorsManager.lightScaffoldColor,
          elevation: 0,
          iconTheme: IconThemeData(color: ColorsManager.black)),
      drawerTheme:
          DrawerThemeData(backgroundColor: ColorsManager.lightScaffoldColor),
      colorScheme:
          ColorScheme.light(background: ColorsManager.lightBackgroundColor),
      iconTheme: IconThemeData(
          color: ColorsManager.lightIPrimaryColor, size: AppSize.s25),
      scaffoldBackgroundColor: ColorsManager.lightScaffoldColor,
      primarySwatch: Colors.grey,
      splashColor: ColorsManager.lightIPrimaryColor,
      primaryColor: ColorsManager.black,
      disabledColor: ColorsManager.grey,
      cardColor: ColorsManager.lightCardColor,
      textTheme: TextTheme(
          headlineLarge:
              getBoldStyle(fontSize: AppSize.s25, color: ColorsManager.black),
          titleLarge: getSemiBoldStyle(
              fontSize: AppSize.s18, color: ColorsManager.black),
          titleMedium:
              getMediumStyle(fontSize: AppSize.s16, color: ColorsManager.black),
          titleSmall: getRegularStyle(
              fontSize: AppSize.s14, color: ColorsManager.black)),
      brightness: Brightness.light);
}

ThemeData getDarkApplicationTheme() {
  return ThemeData(
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: ColorsManager.darkScaffoldColor,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedIconTheme:
              IconThemeData(size: 30, color: ColorsManager.darkIconsColor),
          unselectedIconTheme: const IconThemeData(size: 20),
          showSelectedLabels: false,
          showUnselectedLabels: false),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
        ColorsManager.darkIconsColor,
      ))),
      appBarTheme: AppBarTheme(
          backgroundColor: ColorsManager.darkScaffoldColor,
          elevation: 0,),
      colorScheme:
          ColorScheme.dark(background: ColorsManager.lightBackgroundColor),
      iconTheme:
          IconThemeData(color: ColorsManager.darkIconsColor, size: AppSize.s25),
      scaffoldBackgroundColor: ColorsManager.darkScaffoldColor,
      primarySwatch: Colors.grey,
      splashColor: ColorsManager.darkIconsColor,
      primaryColor: ColorsManager.lightScaffoldColor,
      disabledColor: ColorsManager.grey,
      cardColor: ColorsManager.darkCardColor,
      textTheme: TextTheme(
          headlineLarge: getBoldStyle(
              fontSize: AppSize.s25, color: ColorsManager.lightScaffoldColor),
          titleLarge: getSemiBoldStyle(
              fontSize: AppSize.s18, color: ColorsManager.lightScaffoldColor),
          titleMedium: getMediumStyle(
              fontSize: AppSize.s16, color: ColorsManager.lightScaffoldColor),
          titleSmall: getRegularStyle(
              fontSize: AppSize.s14, color: ColorsManager.lightScaffoldColor)),
      brightness: Brightness.dark);
}
