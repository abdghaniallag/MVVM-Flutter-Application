import 'package:mvvm_first_c/presentation/resources/languge_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
const String PREFS_KEY_LANG="PREFS_KEY_LANG";

class AppPreferences {
  SharedPreferences _sharedPreferences;
  AppPreferences(this._sharedPreferences);
  Future<String> getAppLangague() async{
    String? language=_sharedPreferences.getString(PREFS_KEY_LANG);
    if (language!=null&&language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.ENGLISH.getValue();
    }
  }

  
}