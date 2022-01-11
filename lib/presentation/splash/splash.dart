import 'package:flutter/material.dart';
import 'package:mvvm_first_c/presentation/resources/assets_manager.dart';
import 'package:mvvm_first_c/presentation/resources/color_manager.dart';
import 'dart:async';

import 'package:mvvm_first_c/presentation/resources/routes_manager.dart';
class SplashView extends StatefulWidget {
  
  const SplashView({Key? key}) : super(key: key);



  @override
  _SplashViewState createState() => _SplashViewState();

}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  _startDelay(){
    _timer=Timer(Duration(seconds: 3), _goNext);
  }
  _goNext(){
    Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startDelay();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _timer?.cancel();
        super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: const Center(
        child: Image(
          image: AssetImage(ImageAssets.splashLogo),
        ),
      ),
    );
  }
}
