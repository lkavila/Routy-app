import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:routy_app_v102/Data/models/route.dart';

class CreateRouteFirebase{

  Future<void> createRoute(String routeId, String userId, String origen, String destino, String departamentos, bool circular, String tipoCar, double distancia, double duracion, List<LatLng> markerPoints, List<LatLng> polyPoints, Timestamp createdAt, bool frecuente)async{
    DocumentReference rutas = FirebaseFirestore.instance.collection('routes').doc(routeId);
    if (await rutas.get().then((value) => value.data() == null)) {//se guarda la ruta si no existe
      RouteModel ruta = new RouteModel(
          id: routeId,
          userId: userId,
          createdAt: createdAt,
          frecuente: frecuente,
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
      
      await rutas.set(ruta.toJson());
        print(ruta.toJson());
    }else{
       FirebaseFirestore.instance.collection('routes').doc(routeId)
      .update({'frecuente': frecuente})
      .then((value) => print("route created Updated"))
      .catchError((error) => print("Failed to update route: $error"));
    }
  } 
  }
