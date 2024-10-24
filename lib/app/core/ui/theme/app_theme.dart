import 'package:childrens_stories/app/core/ui/theme/app_color.dart';
import 'package:flutter/material.dart';

ThemeData get lightTheme => ThemeData(
      primaryColor: AppColors.instance.primary,
      primaryColorLight: AppColors.instance.secondary,
      primaryColorDark: AppColors.instance.grey,
      scaffoldBackgroundColor: AppColors.instance.blue,
      colorScheme: ColorScheme.light(
        primary: AppColors.instance.primary,
        secondary: AppColors.instance.secondary,
        tertiary: AppColors.instance.tertiary,
        onTertiary: Colors.white,
        onSurface: AppColors.instance.greyLight,
        surface: AppColors.instance.tertiary,
        inverseSurface: AppColors.instance.grey,
      ),
      dividerTheme: DividerThemeData(
        color: AppColors.instance.dividerColor,
      ),
      listTileTheme: ListTileThemeData(
        tileColor: AppColors.instance.tertiary,
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(color: AppColors.instance.white),
        displayMedium: TextStyle(color: AppColors.instance.white),
        displaySmall: TextStyle(color: AppColors.instance.white),
        headlineMedium: TextStyle(color: AppColors.instance.white),
        headlineSmall: TextStyle(color: AppColors.instance.white),
        titleLarge: TextStyle(color: AppColors.instance.white),
        titleMedium: TextStyle(color: AppColors.instance.white),
        titleSmall: TextStyle(color: AppColors.instance.white),
        bodyLarge: TextStyle(color: AppColors.instance.white),
        bodyMedium: TextStyle(color: AppColors.instance.white),
        bodySmall: TextStyle(color: AppColors.instance.white),
        labelLarge: TextStyle(color: AppColors.instance.white),
        labelSmall: TextStyle(color: AppColors.instance.white),
        headlineLarge: TextStyle(color: AppColors.instance.white),
        labelMedium: TextStyle(color: AppColors.instance.white),
      ),
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
          color: AppColors.instance.primary,
        ),
        backgroundColor: AppColors.instance.blue,
        surfaceTintColor: AppColors.instance.blue,
        titleTextStyle: TextStyle(
          color: AppColors.instance.white,
          fontSize: 28,
        ),
        elevation: 0,
        centerTitle: false,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.instance.tertiary,
        dragHandleColor: AppColors.instance.primary,
      ),
      cardTheme: CardTheme(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      iconTheme: IconThemeData(
        color: AppColors.instance.primary,
      ),
    );
