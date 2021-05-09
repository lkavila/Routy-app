import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

Color colorMode(){
  final appdata = GetStorage();
  appdata.writeIfNull('darkmode', false);
  bool isDarkMode = appdata.read('darkmode');

  if(isDarkMode){
    return Colors.white;
  }else{
    return Colors.blue[800];
  }
  
}