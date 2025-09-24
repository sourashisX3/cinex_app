import 'package:cinex_app/common/constants/size_constants.dart';
import 'package:cinex_app/presentation/themes/app_color.dart';
import 'package:cinex_app/presentation/themes/font_family_constants.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColor.white,
    primaryColor: AppColor.primaryActionColor,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColor.primaryActionColor,
      onPrimary: AppColor.white,
      secondary: AppColor.grey,
      onSecondary: AppColor.black,
      surface: AppColor.white,
      onSurface: AppColor.black,
      error: const Color(0xFFB00020),
      onError: AppColor.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.white,
      foregroundColor: AppColor.black,
      elevation: 0,
      iconTheme: const IconThemeData(color: AppColor.black),
      titleTextStyle: TextStyle(
        color: AppColor.black,
        fontSize: FontSizes.headingLarge,
        fontFamily: FontFamilyConstants.zalandoSansBlack,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primaryActionColor,
        foregroundColor: AppColor.white,
      ),
    ),
    textTheme: TextTheme(
      bodySmall: TextStyle(
        color: AppColor.black,
        fontFamily: FontFamilyConstants.zalandoSansRegular,
      ),
      bodyMedium: TextStyle(
        color: AppColor.black,
        fontSize: FontSizes.bodyMedium,
        fontFamily: FontFamilyConstants.zalandoSansMedium,
      ),
      bodyLarge: TextStyle(
        color: AppColor.black,
        fontSize: FontSizes.bodyLarge,
        fontFamily: FontFamilyConstants.zalandoSansSemiBold,
      ),
      titleLarge: TextStyle(
        color: AppColor.black,
        fontSize: FontSizes.headingLarge,
        fontFamily: FontFamilyConstants.zalandoSansBlack,
      ),
    ),
    iconTheme: const IconThemeData(color: AppColor.black),
    dividerColor: AppColor.grey,
    cardColor: AppColor.white,
    shadowColor: AppColor.grey,
    hintColor: AppColor.grey,
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColor.black,
    primaryColor: AppColor.primaryActionColor,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: AppColor.primaryActionColor,
      onPrimary: AppColor.black,
      secondary: AppColor.grey,
      onSecondary: AppColor.white,
      surface: AppColor.black,
      onSurface: AppColor.white,
      error: const Color(0xFFCF6679),
      onError: AppColor.black,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.black,
      foregroundColor: AppColor.white,
      elevation: 0,
      iconTheme: const IconThemeData(color: AppColor.white),
      titleTextStyle: TextStyle(
        color: AppColor.white,
        fontSize: FontSizes.headingLarge,
        fontFamily: FontFamilyConstants.zalandoSansBlack,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primaryActionColor,
        foregroundColor: AppColor.black,
      ),
    ),
    textTheme: TextTheme(
      bodySmall: TextStyle(
        color: AppColor.white,
        fontSize: FontSizes.bodySmall,
        fontFamily: FontFamilyConstants.zalandoSansRegular,
      ),
      bodyMedium: TextStyle(
        color: AppColor.white,
        fontSize: FontSizes.bodyMedium,
        fontFamily: FontFamilyConstants.zalandoSansMedium,
      ),
      bodyLarge: TextStyle(
        color: AppColor.white,
        fontSize: FontSizes.bodyLarge,
        fontFamily: FontFamilyConstants.zalandoSansSemiBold,
      ),
      titleLarge: TextStyle(
        color: AppColor.white,
        fontSize: FontSizes.headingLarge,
        fontFamily: FontFamilyConstants.zalandoSansBlack,
      ),
    ),
    iconTheme: const IconThemeData(color: AppColor.white),
    dividerColor: AppColor.grey,
    cardColor: AppColor.black,
    shadowColor: AppColor.grey,
    hintColor: AppColor.grey,
  );
}
