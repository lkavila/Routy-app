
import 'package:get/get.dart';

class Elegido extends GetxController{
  String elegido = "";

  actualizar(String elegido){
    this.elegido = elegido;
    update();
  }
} 