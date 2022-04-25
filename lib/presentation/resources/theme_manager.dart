import 'package:flutter/material.dart';
import 'color_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';
import 'values_manager.dart';

ThemeData getAplicationTheme() {
  return ThemeData(
// main colors of app
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primaryOpacity70,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.gray1,
    accentColor: ColorManager.gray2,

// card view theme
    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.gray,
      elevation: AppSize.s4,
    ),
// app bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primary,
      elevation: AppSize.s4,
      shadowColor: ColorManager.primaryOpacity70,
      titleTextStyle:
          getRegularStyle(color: ColorManager.white, fontSize: FontSize.s14),
    ),
// button theme
    buttonTheme: ButtonThemeData(
        shape: StadiumBorder(),
        disabledColor: ColorManager.gray1,
        buttonColor: ColorManager.primary,
        splashColor: ColorManager.primaryOpacity70),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(color: ColorManager.white),
        primary: ColorManager.primary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s12)),
      ),
    ),
// Text theme
    textTheme: TextTheme(
      headline1: getSemiBoldStyle(
          color: ColorManager.darkGray, fontSize: FontSize.s16),
      headline2:
          getRegularStyle(color: ColorManager.white, fontSize: FontSize.s16),
      headline3:
          getBoldStyle(color: ColorManager.primary, fontSize: FontSize.s16),
      subtitle1:
          getMediumStyle(color: ColorManager.lightGray, fontSize: FontSize.s14),
      subtitle2:
          getMediumStyle(color: ColorManager.primary, fontSize: FontSize.s14),
      caption: getRegularStyle(color: ColorManager.gray1),
      bodyText1: getRegularStyle(color: ColorManager.gray),
    ),
// input decoration theme(text form field )
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(AppPadding.p8),
      hintStyle: getRegularStyle(color: ColorManager.gray1),
      labelStyle: getMediumStyle(color: ColorManager.darkGray),
      errorStyle: getRegularStyle(color: ColorManager.error),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
          borderSide:
              BorderSide(color: ColorManager.gray, width: AppSize.s1_5)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
          borderSide:
              BorderSide(color: ColorManager.primary, width: AppSize.s1_5)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
          borderSide:
              BorderSide(color: ColorManager.error, width: AppSize.s1_5)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
          borderSide:
              BorderSide(color: ColorManager.primary, width: AppSize.s1_5)),
    ),
  );
}
