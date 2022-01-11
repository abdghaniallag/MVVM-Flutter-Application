import 'package:flutter/material.dart';
import 'color_manager.dart';
import 'font_manager.dart';

TextStyle _getTextStyle(double fontSize,String fontFamily,FontWeight fontWeight, color){
  return TextStyle(fontSize: fontSize,fontFamily: fontFamily,color: color);
}
//regular
TextStyle getRegularStyle({double fontSize:FontSize.s12,required Color color}){
  return _getTextStyle(fontSize, FontConstants.fonntFamily,
  FontWeightManager.regular ,color);
}

//medium
TextStyle getMediumStyle({double fontSize:FontSize.s12,required Color color}){
  return _getTextStyle(fontSize, FontConstants.fonntFamily,
  FontWeightManager.medium ,color);
}

//semiBold
TextStyle getSemiBoldStyle({double fontSize:FontSize.s12,required Color color}){
  return _getTextStyle(fontSize, FontConstants.fonntFamily,
  FontWeightManager.semiBold ,color);
}

//light
TextStyle getLightStyle({double fontSize:FontSize.s12,required Color color}){
  return _getTextStyle(fontSize, FontConstants.fonntFamily,
  FontWeightManager.light ,color);
}

//bold
TextStyle getBoldStyle({double fontSize:FontSize.s12,required Color color}){
  return _getTextStyle(fontSize, FontConstants.fonntFamily,
  FontWeightManager.bold ,color);
}
