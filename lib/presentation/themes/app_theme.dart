import 'package:cinex_app/common/constants/size_constants.dart';
import 'package:cinex_app/presentation/themes/app_color.dart';
import 'package:cinex_app/presentation/themes/font_family_constants.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColor.scaffoldLight,
    brightness: Brightness.light,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.buttonLightMode,
      ),
    ),
    textTheme: TextTheme(
      bodySmall: TextStyle(color: AppColor.textLightMode),
      bodyLarge: TextStyle(color: AppColor.textLightMode),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColor.black,
    brightness: Brightness.dark,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(backgroundColor: AppColor.buttonDarkMode),
    ),
    textTheme: TextTheme(
      bodySmall: TextStyle(color: AppColor.textDarkMode),
      bodyLarge: TextStyle(
        color: AppColor.white,
        fontSize: FontSizes.headingLarge,
        fontFamily: FontFamilyConstants.zalandoSansBlack,
        
      ),
    ),
  );
}
