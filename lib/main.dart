import 'package:flutter/material.dart';
import 'package:mvvm_first_c/app/di.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(MyApp());
}
