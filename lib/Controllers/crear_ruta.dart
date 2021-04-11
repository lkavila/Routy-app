import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:routy_app_v102/models/route.dart';

class CrearRuta {

 static Future< void>  crear(MyRoute ruta){
    CollectionReference rutas = FirebaseFirestore.instance.collection('routes');
    return rutas.add(ruta.toJson());
  }

  static Future<void> editar(){
    return null; //es necesario editar vehiculos¿?
  }
}