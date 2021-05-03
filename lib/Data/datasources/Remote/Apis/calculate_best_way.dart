import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:routy_app_v102/Data/datasources/Remote/Apis/networking.dart';
import 'package:routy_app_v102/Data/datasources/Remote/Apis/tsp.dart';


class CalculateBestWay{
  
  Future getBestWay(List<LatLng> lugares, String circular) async{

    OpenRouteS _orsTsp = OpenRouteS();
    
    dynamic data = await _orsTsp.getRoute(lugares, circular);

    if (data!=400){
      print("Esta es la distancia minima: "+data['distanciaMinima'].toString());
      List<dynamic> coordenadas = data['caminoMinimo'];
      print("el orden del camino más corto es ${data["orden"]}");

      OpenRoute _openDirections = OpenRoute();

      return await _openDirections.getPolylines(coordenadas, circular);

      }else{

        return null;
      }
  }

}