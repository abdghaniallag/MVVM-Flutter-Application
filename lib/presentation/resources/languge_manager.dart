enum LanguageType { ENGLISH, ARABIC }
const String ENGLISH="en";
const String ARABIC="ar";

extension LanguageTypeExtention on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.ENGLISH:
        return  ARABIC;
      case LanguageType.ARABIC:
        return  ARABIC;
    }
  }
}
