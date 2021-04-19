import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:routy_app_v102/Data/datasources/Remote/Firebase/create_route.dart';
import 'package:routy_app_v102/Data/datasources/Remote/Firebase/get_user_routes.dart';
import 'package:routy_app_v102/Data/datasources/Remote/Apis/HereGeocode.dart';
import 'package:routy_app_v102/Data/datasources/Remote/Apis/networking.dart';
import 'package:routy_app_v102/Data/models/route.dart';
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
  Future<List<RouteModel>> getUserRoutes() async{
    final GetUserRoutes _getRoutes = GetUserRoutes();
    return await _getRoutes.getRutas();
  }

  @override
  void createRoute(covariant RouteModel ruta){
    final CreateRouteFirebase _createRoute = CreateRouteFirebase();
    _createRoute.createRoute(ruta);
  }
}