import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:routy_app_v102/Data/repositories/route_repository_impl.dart';
import 'package:routy_app_v102/Domain/repositories/route_repository.dart';

mixin CreateRouteUseCase{
  Future<void> call(String id,String userId, String origen, String destino, String departamentos, bool circular, String tipoCar, double distancia, double duracion, List<LatLng> markerPoints, List<LatLng> polyPoints, Timestamp createdAt, bool frecuente);
}

class CreateRoute implements CreateRouteUseCase{
  final RouteRepository _routeRepository =  RouteRepositoryImpl();
  @override

  Future<void> call(String id, String userId, String origen, String destino, String departamentos, bool circular, String tipoCar, double distancia, double duracion, List<LatLng> markerPoints, List<LatLng> polyPoints, Timestamp createdAt, bool frecuente)async{
    await _routeRepository.createRoute(id, userId, origen, destino, departamentos, circular, tipoCar, distancia, duracion, markerPoints, polyPoints, createdAt, frecuente);
  }
}