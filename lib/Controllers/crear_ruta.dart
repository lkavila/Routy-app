import 'package:get/get.dart';
import 'package:routy_app_v102/Domain/entities/route.dart';
import 'package:routy_app_v102/Presentation/GetX/route.dart';

class CrearRuta {



  static Future<void> editar(){
    return null; //es necesario editar vehiculos¿?
  }

  static actualizarRutas(RouteEntity ruta){
    final RouteX routeX = Get.find();
    routeX.misRutas.add(ruta);
  }
}