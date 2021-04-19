import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:routy_app_v102/Domain/entities/route.dart';
import 'package:routy_app_v102/Domain/usecases/Routes/create_route.dart';
import 'package:routy_app_v102/Domain/usecases/Routes/get_direction_from_geocode_reverse.dart';
import 'package:routy_app_v102/Domain/usecases/Routes/get_polylines_from_ors.dart';
import 'package:routy_app_v102/Domain/usecases/Routes/get_user_routes.dart';
import 'package:routy_app_v102/Presentation/GetX/user_controller.dart';

class RouteController extends GetxController{
  List<RouteEntity> misRutas = [];
  List<LatLng> polyPoints = []; // For holding Co-ordinates as LatLng
  Set<Polyline> polyLines = {}; // For holding instance of Polyline
  Set<Marker> markers = {}; // For holding instance of Marker
  List<LatLng> puntos = []; 
  RouteEntity ruta;
  int tipoMenu = 0;
  BitmapDescriptor start, finish;
  var cargandoRutas = false.obs;
  var cargandoDirecciones = false.obs;
  var cargandoPolylines = false.obs;


  void getRutas() async{
    final GetUserRoutesUseCase _getUserRoutes = GetUserRoutesUC();
    cargandoRutas.value = true;
    await _getUserRoutes.call().then((value) => misRutas = value);
    update();
    cargandoRutas.value = false;
  }

  Future<void> createRoute(String circular) async{
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
        setPolyLines();
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
      final UserController userx = Get.find();
      ruta = new RouteEntity(
        userId: userx.user.id,
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
    print("saving route");
    _createRoute.call(ruta.userId, ruta.origen, ruta.destino, ruta.departamentos, ruta.circular, ruta.tipoCar, ruta.distancia, ruta.duracion, ruta.markerPoints, ruta.polyPoints, ruta.createdAt);
    print(ruta.createdAt);
    misRutas.add(ruta);
  }

  void actualizarRutas(RouteEntity ruta){
    misRutas.add(ruta);
  }

  limpiar(){
    misRutas = [];
  }

  setPolyLines() {
    Polyline polyline = Polyline(
      polylineId: PolylineId("polyline"),
      color: Colors.blue[700],
      points: polyPoints,
      width: 3,
    );
    polyLines.add(polyline);
    update();
  }


    createMarkers(double lat, double lng) {
      puntos.add(LatLng(lat, lng));
      if (markers.isEmpty){
      markers.add(
        Marker(
          markerId: MarkerId("1"),
          position: LatLng(lat, lng),
          icon: start,
          infoWindow: InfoWindow(
            title: "Home",
          ),
          onTap: (){
              /*showDialog(
                context: context,
                builder: (context) => AlertDialog(
              title: Text("Modificar marker"),
              content: Container(
                height: 150,
                child: Column(

                  children: [
                    TextButton(onPressed: (){
                      Utils.hacerInicio(markers, marker);
                      },
                      child: Text("Hacer inicio")),

                    TextButton(onPressed: (){
                      Utils.hacerInicio(markers, marker);
                      },
                      child: Text("Hacer inicio")),

                    TextButton(onPressed: (){
                      Utils.hacerInicio(markers, marker);
                      },
                      child: Text("Hacer inicio")),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: (){

                  Navigator.of(context, rootNavigator: true).pop();

                }, child: Text("Cancelar"))
              ],
            ),
            ).then((value) => null); */
            
              //marker = markers.where((element) => element.position==LatLng(lat, lng)).single;
              markers.removeWhere((element) => element.markerId==MarkerId(lat.toString()));
              puntos.removeWhere((element) => (element == LatLng(lat, lng)));            
         
          }
        ),
      );       
      }else markers.add(
        Marker(
          markerId: MarkerId(lat.toString()),
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(
            title: "Home",
            snippet: "lat: "+lat.toString(),
          ),
          onTap: (){
              markers.removeWhere((element) => element.markerId==MarkerId(lat.toString()));
              puntos.removeWhere((element) => (element == LatLng(lat, lng)));     
          }
        ),
      );
      update();
    }

  showChooseRouteOnMap(RouteEntity ruta){
    this.ruta = null;
    this.polyLines.clear();
    this.polyPoints.clear();
    this.markers.clear();
    this.puntos.clear();
    this.ruta = ruta;
    this.polyPoints = ruta.polyPoints;
    setPolyLines();
    print("crear markers");
    this.ruta.markerPoints.forEach((element) {
      createMarkers(element.latitude, element.longitude);
      });
  }
  @override
  void onInit() {
    print("init state route");
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(130, 130)), 'assets/images/map.png')
        .then((onValue) {
      finish = onValue;
    });

    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(130, 130)),
            'assets/images/location.png')
        .then((onValue) {
      start = onValue;
    });
    super.onInit();
  }
}



//Create a new class to hold the Co-ordinates we've received from the response data
class LineString {
  LineString(this.lineString);
  List<dynamic> lineString;
}