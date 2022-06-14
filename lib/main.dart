import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:mvvm_first_c/app/di.dart';
import 'package:mvvm_first_c/presentation/resources/languge_manager.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(EasyLocalization(
      child: Phoenix(child: MyApp()),
      supportedLocales: [ENGLISH_LOCAL, ARABIC_LOCAL],
      path: ASSETS_PATH_LOCALIZATION));
}
