import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/Presentation/GetX/route.dart';
import 'package:routy_app_v102/models/route.dart';

class CrearRuta {

 static Future<void>  crear(MyRoute ruta){
    CollectionReference rutas = FirebaseFirestore.instance.collection('routes');
    actualizarRutas(ruta);
    return rutas.add(ruta.toJson());
  }

  static Future<void> editar(){
    return null; //es necesario editar vehiculos¿?
  }

  static actualizarRutas(MyRoute ruta){
    final RouteX routeX = Get.find();
    routeX.misRutas.add(ruta);
  }
}