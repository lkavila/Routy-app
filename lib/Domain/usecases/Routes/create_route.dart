import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:routy_app_v102/Data/repositories/route_repository_impl.dart';
import 'package:routy_app_v102/Domain/repositories/route_repository.dart';

mixin CreateRouteUseCase{
  void call(String userId, String origen, String destino, String departamentos, bool circular, String tipoCar, double distancia, double duracion, List<LatLng> markerPoints, List<LatLng> polyPoints, Timestamp createdAt);
}

class CreateRoute implements CreateRouteUseCase{
  final RouteRepository _routeRepository =  RouteRepositoryImpl();
  @override

  void call(String userId, String origen, String destino, String departamentos, bool circular, String tipoCar, double distancia, double duracion, List<LatLng> markerPoints, List<LatLng> polyPoints, Timestamp createdAt){
    _routeRepository.createRoute(userId, origen, destino, departamentos, circular, tipoCar, distancia, duracion, markerPoints, polyPoints, createdAt);
  }
}