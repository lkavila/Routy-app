import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:routy_app_v102/Data/datasources/Remote/Firebase/Routes/create_route.dart';
import 'package:routy_app_v102/Data/datasources/Remote/Firebase/Routes/get_user_routes.dart';
import 'package:routy_app_v102/Data/datasources/Remote/Apis/HereGeocode.dart';
import 'package:routy_app_v102/Data/datasources/Remote/Apis/networking.dart';
import 'package:routy_app_v102/Data/datasources/Remote/Firebase/Routes/make_frecuent.dart';
import 'package:routy_app_v102/Domain/entities/route.dart';
import 'package:routy_app_v102/Domain/repositories/route_repository.dart';

class RouteRepositoryImpl implements RouteRepository{

  @override
  Future<List<String>> fetchGeo(double lon, double lat) async{
    final GeoCodeReverse _geoRV = GeoCodeReverse();
    return await _geoRV.fetchGeo(lon, lat);
  }

  @override
  Future getPolylines(List<LatLng> lugares, String circular) async{
    final OpenRoute _op = OpenRoute();
    return await _op.getPolylines(lugares, circular);
  }

  @override
  Future<List<RouteEntity>> getUserRoutes() async{
    final GetUserRoutes _getRoutes = GetUserRoutes();
    return await _getRoutes.getRutas();
  }

  @override
  Future<void> createRoute(String id,String userId, String origen, String destino, String departamentos, bool circular, String tipoCar, double distancia, double duracion, List<LatLng> markerPoints, List<LatLng> polyPoints, Timestamp createdAt, bool frecuente)async{
    final CreateRouteFirebase _createRoute = CreateRouteFirebase();
    await _createRoute.createRoute(id, userId, origen, destino, departamentos, circular, tipoCar, distancia, duracion, markerPoints, polyPoints, createdAt, frecuente);
  }
  @override
  void makeFrecuent(String id, bool frecuente){
    final RouteMakeFrecuentFirebase _createRoute = RouteMakeFrecuentFirebase();
    _createRoute.makeFrecuent(id, frecuente);
  }
}