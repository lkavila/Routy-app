import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:routy_app_v102/Domain/entities/route.dart';
import 'package:routy_app_v102/Domain/usecases/Routes/create_route.dart';
import 'package:routy_app_v102/Domain/usecases/Routes/get_direction_from_geocode_reverse.dart';
import 'package:routy_app_v102/Domain/usecases/Routes/get_polylines_from_ors.dart';
import 'package:routy_app_v102/Domain/usecases/Routes/get_user_routes.dart';
import 'package:routy_app_v102/Presentation/GetX/user.dart';

class RouteX extends GetxController{
  List<RouteEntity> misRutas = [];
  List<LatLng> polyPoints = []; // For holding Co-ordinates as LatLng
  List<LatLng> puntos = []; 
  RouteEntity ruta;
  var cargandoRutas = false.obs;
  var cargandoDirecciones = false.obs;
  var cargandoPolylines = false.obs;


  void getRutas(){
    print("object");
    final GetUserRoutesUseCase _getUserRoutes = GetUserRoutesUC();
    cargandoRutas.value = true;
    _getUserRoutes.call().then((value) => misRutas = value);
    update();
    cargandoRutas.value = false;
  }

  void createRoute(String circular) async{
    double distancia, duracion;
    final GetPolylinesFromORSUseCase _getPolylines = GetPolylinesFromORS();
    cargandoPolylines.value = true;
    var data = await _getPolylines.call(puntos, circular);
    try {
      if(data!=null){
        // We can reach to our desired JSON data manually as following
        LineString ls =
            LineString(data['features'][0]['geometry']['coordinates']);
        for (int i = 0; i < ls.lineString.length; i++) {
          polyPoints.add(LatLng(ls.lineString[i][1], ls.lineString[i][0]));
        }
        
        distancia = data['features'][0]['properties']['summary']["distance"];
        duracion = data['features'][0]['properties']['summary']["duration"];
      }
    } catch (e) {
      print(e);
    }
    cargandoPolylines.value = false;
    final GetDirectionGeocodeRvUseCase _getDirections = GetDirectionGeocodeRv();
    cargandoDirecciones.value = true;
    List<String> dirOrigen = await _getDirections.call(puntos.first.longitude, puntos.first.latitude);
    List<String> dirDestino = await _getDirections.call(puntos.last.longitude, puntos.last.latitude);
    cargandoDirecciones.value = false;
    print(dirDestino);
    print(dirOrigen);
    if(dirDestino!=null && dirOrigen!=null){
      String departamentoO = dirOrigen.last;
      String departamentoD = dirDestino.last;
      String departamentos;
      if(departamentoO!=departamentoD){
        departamentos = departamentoO+" "+departamentoD;
      }else{
        departamentos = departamentoD;
      }

      bool cir = circular=="true";
      final UserX userx = Get.find();
      ruta = new RouteEntity(
        userId: userx.myUser.id,
        createdAt: Timestamp.now(),
        origen: dirOrigen.first,
        destino: dirDestino.first,
        circular: cir,
        distancia: distancia,
        duracion: duracion,
        departamentos: departamentos,
        markerPoints: puntos,
        polyPoints: polyPoints,
        tipoCar: "driving-car"
      );
      update();
      
    }
  }

  Future<List<String>> getDirection(double lon, double lat) async{
    final GetDirectionGeocodeRvUseCase _getDirection = GetDirectionGeocodeRv();
    cargandoDirecciones.value = true;
    return await _getDirection.call(lon, lat);
    //cargandoDirecciones.value = false;
  }

  void saveRoute(RouteEntity ruta){
    final CreateRouteUseCase _createRoute = CreateRoute();
    _createRoute.call(ruta);
  }

  limpiar(){
    misRutas = [];
  }

}

//Create a new class to hold the Co-ordinates we've received from the response data
class LineString {
  LineString(this.lineString);
  List<dynamic> lineString;
}