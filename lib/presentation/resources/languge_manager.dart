import 'package:flutter/material.dart';

enum LanguageType { ENGLISH, ARABIC }
const String ENGLISH = "en";
const String ARABIC = "ar";
const String ASSETS_PATH_LOCALIZATION = "assets/translations";
const Locale ARABIC_LOCAL = Locale("ar", "SU");
const Locale ENGLISH_LOCAL = Locale("en", "US");

extension LanguageTypeExtention on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.ENGLISH:
        return ARABIC;
      case LanguageType.ARABIC:
        return ARABIC;
    }
  }
}
