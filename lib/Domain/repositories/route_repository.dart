import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:routy_app_v102/Domain/entities/route.dart';

abstract class RouteRepository{

  Future<List<String>> fetchGeo(double lon, double lat);

  Future getPolylines(List<LatLng> lugares, String circular);

  Future<List<RouteEntity>> getUserRoutes();

  Future<void> createRoute(String id,String userId, String origen, String destino, String departamentos, bool circular, String tipoCar, double distancia, double duracion, List<LatLng> markerPoints, List<LatLng> polyPoints, Timestamp createdAt, bool frecuente);
  
  void makeFrecuent(String id, bool frecuente);
}