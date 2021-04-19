import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:routy_app_v102/Data/models/route.dart';

class CreateRouteFirebase{

  Future createRoute(RouteModel ruta){
    CollectionReference rutas = FirebaseFirestore.instance.collection('routes');
    return rutas.add(ruta.toJson());
  }
}