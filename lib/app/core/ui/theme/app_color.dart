import 'package:flutter/material.dart';

class AppColors {
  static AppColors? _instance;

  AppColors._();

  static AppColors get instance => _instance ??= AppColors._();

  //theme light
  Color get primary => const Color(0xFF023EA6);
  Color get secondary => const Color(0xFF185DD4);
  Color get tertiary => const Color(0xFFF3F3F3);
  Color get grey => const Color(0xFF3A3A3A);
  Color get greyLight => const Color(0xFF838383);
  Color get blue => const Color(0xFF87CEEB);
  Color get white => Colors.white;
  Color get black => Colors.black;

  //theme dark
  Color get primaryDark => const Color.fromARGB(255, 66, 115, 206);
  Color get secondaryDark => const Color(0xFF185DD4);
  Color get tertiaryDark => const Color(0xFF191919);
  Color get greyDark => const Color(0XFF202020);
  Color get greyLightDark => const Color(0xFF9B9B9B);

  Color get dividerColor => const Color(0xFFB6B6B6);
}

extension ColorsAppExtensions on BuildContext {
  AppColors get colors => AppColors.instance;
}
