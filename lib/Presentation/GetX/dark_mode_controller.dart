import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class DarkModeController extends GetxController{
  
  bool gradientColors = false;
  final List<Color> _colorsLight = [Colors.blue, Colors.lightBlueAccent, Color.fromRGBO(11, 210, 181, 1)];
  final List<Color> _colorsDark = [Colors.indigo[900],Colors.blue[800],Colors.cyanAccent[400]];
  bool isDarkMode = false;
  final Color colorRutaLigth = Color.fromRGBO(130, 230, 250, 0.9);
  final Color colorRutaDark = Color.fromRGBO(10, 50, 120, 0.9);
  
  changeMode(bool value){
    final appdata = GetStorage();
    appdata.write('darkmode', value);
    isDarkMode = value;
  }

  changeGradientColors(){
    gradientColors ? gradientColors=false : gradientColors=true;
    update();
  }

  Color colorMode(){

  if(isDarkMode){
    return Colors.white;
  }else{
    return Colors.blue[900];
  }
}

List<Color> colorsGradient(bool color){
  if (color){
    return _colorsDark;
  }else{
    return _colorsLight;
  }
}

Color colorRuta(){
  if (isDarkMode){
    return colorRutaDark;
  }else{
    return colorRutaLigth;
  }
}

@override
  void onInit() {
    final appdata = GetStorage();
    appdata.writeIfNull('darkmode', false);
    isDarkMode = appdata.read('darkmode');
    super.onInit();
  }
}