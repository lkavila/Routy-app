import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:routy_app_v102/Domain/entities/route.dart';

abstract class RouteRepository{

  Future<List<String>> fetchGeo(double lon, double lat);

  Future getPolylines(List<LatLng> lugares, String circular);

  Future<List<RouteEntity>> getUserRoutes();

  void createRoute(RouteEntity ruta);
  
}