import 'dart:ui';

import 'package:testing_firebase/core/constants/appTheme.dart';

class ColorPickerHelper{
  static Color colorHelper(String color){
    if(color == 'backgroundColor'){
      return (appTheme().theme == 'Light'? Color(0xFFF5F6FA) : Color(0xFF101832));
    }else if(color == 'buttonColor') {
      return (appTheme().theme == 'Light'? Color(0xFF6556FF) : Color(0xFF6556FF));
    }else if(color == 'mainTextColor') {
      return (appTheme().theme == 'Light'? Color(0xFF333E63) : Color(0xFFFFFFFF));
    }else if(color == 'secondaryTextColor') {
      return (appTheme().theme == 'Light'? Color(0xFF949494) : Color(0xFF949494));
    }else if(color == 'fieldBackgroundColor') {
      return (appTheme().theme == 'Light'? Color(0xFFFFFFFF) : Color(0xFF272E46));
    }else if(color == 'fieldTextColor') {
      return (appTheme().theme == 'Light'? Color(0xFF565656) : Color(0xFFBDBDBD));
    }else if(color == 'hyperlinkTextColor') {
      return (appTheme().theme == 'Light'? Color(0xFF1162EB) : Color(0xFF1162EB));
    }else{
      return Color(0xFFFFFFFF);
    }
  }
}