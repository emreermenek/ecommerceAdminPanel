import 'package:bestshop_adminpanel/consts/color_data.dart';
import 'package:flutter/material.dart';

class Themes {
  static ThemeData themeData(
      {required bool isDarkTheme, required BuildContext context}) {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: isDarkTheme
          ? ColorData.darkScaffoldColor
          : ColorData.lightScaffoldColor,
      primaryColor: isDarkTheme
          ? ColorData.darkPrimaryColor
          : ColorData.lightPrimaryColor,
      appBarTheme: AppBarTheme(
          iconTheme:
              IconThemeData(color: isDarkTheme ? Colors.white : Colors.black),
          backgroundColor: isDarkTheme
              ? ColorData.darkScaffoldColor
              : ColorData.lightScaffoldColor),
      cardColor:
          isDarkTheme ? ColorData.darkCardColor : ColorData.lightCardColor,
      colorScheme: ColorScheme.fromSeed(
          brightness: isDarkTheme ? Brightness.dark : Brightness.light,
          seedColor: isDarkTheme
              ? ColorData.darkPrimaryColor
              : ColorData.lightPrimaryColor),
      inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 1, color: isDarkTheme ? Colors.white : Colors.black),
            borderRadius: BorderRadius.circular(18),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 1, color: isDarkTheme ? Colors.white : Colors.black),
            borderRadius: BorderRadius.circular(18),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 1, color: Theme.of(context).colorScheme.error),
            borderRadius: BorderRadius.circular(18),
          )),
    );
  }
}
