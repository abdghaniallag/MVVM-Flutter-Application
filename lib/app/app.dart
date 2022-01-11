
import 'package:flutter/material.dart';
import 'package:mvvm_first_c/presentation/resources/routes_manager.dart';
import 'package:mvvm_first_c/presentation/resources/theme_manager.dart'; 
class MyApp extends StatefulWidget {  
  MyApp._internal();// privat named constrictor
  static final MyApp instance=MyApp._internal();
  factory MyApp()=> instance;
    @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
onGenerateRoute: RouteGenerator.getRoute,
initialRoute:Routes.splashRoute,
theme:getAplicationTheme(),

    );
  }
} 