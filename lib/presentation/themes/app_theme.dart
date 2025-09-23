import 'package:cinex_app/common/constants/size_constants.dart';
import 'package:cinex_app/presentation/themes/app_color.dart';
import 'package:cinex_app/presentation/themes/font_family_constants.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColor.white,
    brightness: Brightness.light,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primaryActionColor,
      ),
    ),

    /*  colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: AppColor.primaryActionColor,
      brightness: Brightness.light,
    ), */
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
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColor.black,
    brightness: Brightness.dark,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primaryActionColor,
      ),
    ),
    /* colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: AppColor.primaryActionColor,
      brightness: Brightness.dark,
    ), */
    textTheme: TextTheme(
      bodySmall: TextStyle(
        color: AppColor.white,
        fontSize: FontSizes.bodySmall,
        fontFamily: FontFamilyConstants.zalandoSansRegular,
      ),
      bodyLarge: TextStyle(
        color: AppColor.white,
        fontSize: FontSizes.bodyLarge,
        fontFamily: FontFamilyConstants.zalandoSansSemiBold,
      ),
      bodyMedium: TextStyle(
        color: AppColor.white,
        fontSize: FontSizes.bodyMedium,
        fontFamily: FontFamilyConstants.zalandoSansMedium,
      ),
      titleLarge: TextStyle(
        color: AppColor.white,
        fontSize: FontSizes.headingLarge,
        fontFamily: FontFamilyConstants.zalandoSansBlack,
      ),
    ),
  );
}
