import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:routy_app_v102/Data/models/route.dart';

class CreateRouteFirebase{

  Future createRoute(String userId, String origen, String destino, String departamentos, bool circular, String tipoCar, double distancia, double duracion, List<LatLng> markerPoints, List<LatLng> polyPoints, Timestamp createdAt) async{
    CollectionReference rutas = FirebaseFirestore.instance.collection('routes');
    RouteModel ruta = new RouteModel(
        userId: userId,
        createdAt: createdAt,
        origen: origen,
        destino: destino,
        circular: circular,
        distancia: distancia,
        duracion: duracion,
        departamentos: departamentos,
        markerPoints: markerPoints,
        polyPoints: polyPoints,
        tipoCar: tipoCar
    );
    return await rutas.add(ruta.toJson());
  }
}