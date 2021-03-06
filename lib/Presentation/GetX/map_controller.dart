import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:routy_app_v102/Data/datasources/Remote/Apis/networking.dart';
import 'package:routy_app_v102/Domain/entities/route.dart';
import 'package:routy_app_v102/Domain/entities/routeDTO.dart';
import 'package:routy_app_v102/Domain/usecases/Routes/create_route.dart';
import 'package:routy_app_v102/Domain/usecases/Routes/get_best_way.dart';
import 'package:routy_app_v102/Domain/usecases/Routes/get_direction_from_geocode_reverse.dart';
import 'package:routy_app_v102/Domain/usecases/Routes/make_frecuent.dart';
import 'package:routy_app_v102/Presentation/GetX/route_controller.dart';
import 'package:routy_app_v102/Presentation/GetX/user_controller.dart';
import 'package:uuid/uuid.dart';

class MapController extends GetxController{
  List<LatLng> polyPoints = []; // For holding Co-ordinates as LatLng
  Set<Polyline> polyLines = {}; // For holding instance of Polyline
  Set<Marker> markers = {}; // For holding instance of Marker
  List<LatLng> puntos = []; 
  int tipoMenu = 0;
  RouteEntity ruta;
  BitmapDescriptor start, finish;
  var cargandoDirecciones = false.obs;
  var cargandoPolylines = false.obs;
  double lat;
  double lon;
  bool trafficMode = false;

  void actualizarTrafficMode(){
    trafficMode = trafficMode ? false : true;
    update(); 
  }

  void actualizarMenu(int tipo){
    tipoMenu = tipo;
    update();
  }

  Future<double> distanciaFaltante(double lat, double lon)async{
    OpenRoute _op = new OpenRoute();
    List<dynamic> pun = [];
    List<double> dou = [];
    List<double> dou2 = [];
    dou.add(lon);
    dou.add(lat);
    pun.add(dou);
    dou2.add(puntos.last.longitude);
    dou2.add(puntos.last.latitude);
    pun.add(dou2);
    var data = await _op.getPolylines(pun, 'false');
    try {
      if(data!=null){
        print(data['features'][0]['properties']['summary']["distance"]);
        return data['features'][0]['properties']['summary']["distance"];
      }
    } catch (e) {
      print(e);
      print("Yaper");
    }
    return null;
  }

  Future<void> createRoute(String circular) async{
    double distancia, duracion;
    final GetBestWayUseCase _getPolylines = GetBestWay();
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
        duracion = data['features'][0]['properties']['summary']["duration"]+60*5*markers.length;
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
        id: Uuid().v1(),
        userId: userx.user.id,
        createdAt: Timestamp.now(),
        origen: dirOrigen.first,
        destino: dirDestino.first,
        circular: cir,
        frecuente: false,
        distancia: distancia,
        duracion: duracion*1.05,
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

  setPolyLines() {
    Polyline polyline = Polyline(
      polylineId: PolylineId("polyline"),
      color: Colors.blue,
      points: polyPoints,
      width: 3,
    );
    polyLines.add(polyline);
  }


    createMarkers(double lat, double lng, BitmapDescriptor img, int cont) {
      puntos.add(LatLng(lat, lng));
      markers.add(doCreateMarker(lat, lng, img, cont));       
    }

    createMarkerFromTap(double lat, double lng, BitmapDescriptor img, int cont) {
      puntos.add(LatLng(lat, lng));
      if(markers.length>1){
        Marker lastMarker = markers.last;
        markers.remove(lastMarker);
        Marker newLastMarker = doCreateMarker(lastMarker.position.latitude, lastMarker.position.longitude, BitmapDescriptor.defaultMarker, markers.length);
        markers.add(newLastMarker);
      }
      markers.add(doCreateMarker(lat, lng, img, cont));

      update();       
    }

  Marker doCreateMarker(double lat, double lng, BitmapDescriptor img, int cont){

        return Marker(
          markerId: MarkerId(cont.toString()),
          position: LatLng(lat, lng),
          icon: img,
          infoWindow: InfoWindow(
            title: cont.toString(),
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
              
              //markers.removeWhere((element) => element.markerId==MarkerId(lat.toString()));
              //puntos.removeWhere((element) => (element == LatLng(lat, lng)));            
         
          }
        );
  }


  showChooseRouteOnMap(RouteEntity ruta){
    this.ruta = null;
    this.polyLines = {};
    this.polyPoints = [];
    this.markers = {};
    this.puntos = [];
    this.ruta = ruta;
    this.polyPoints = ruta.polyPoints;
    setPolyLines();
    print("crear markers");
    int cont = 1;
    ruta.markerPoints.forEach((element) {
      if (markers.isEmpty){
        createMarkers(element.latitude, element.longitude, start, cont);
      }else{
        if (markers.length == this.ruta.markerPoints.length-1){
            createMarkers(element.latitude, element.longitude, finish, cont);
        }else{
            createMarkers(element.latitude, element.longitude, BitmapDescriptor.defaultMarker, cont);
        }        
      }

      cont++;
      });
      //update();
  }

  BitmapDescriptor markerImage(){
      if (markers.isEmpty){
        return start;
      }else{
        return finish;
      }
  }

  void makeFrecuent()async{
    final RouteController _rc = Get.find();
    if(_rc.misRutas.contains(ruta)){
      RouteEntity route =_rc.misRutas.firstWhere((element) => element.id==ruta.id);
      _rc.misRutas.remove(route);
      RouteDTO routeDto =_rc.misRutasDto.firstWhere((element) => element.id==ruta.id);
      _rc.misRutasDto.remove(routeDto);
      final MakeFrecuentUseCase _makef = MakeFrecuent();
      _makef.call(ruta.id, !ruta.frecuente);

    }else{
      final CreateRouteUseCase _createRoute = CreateRoute();
      _createRoute.call(ruta.id, ruta.userId, ruta.origen, ruta.destino, ruta.departamentos, ruta.circular, ruta.tipoCar, ruta.distancia, ruta.duracion, ruta.markerPoints, ruta.polyPoints, ruta.createdAt, ruta.frecuente);
      
    }
    ruta.frecuente = ruta.frecuente ? false : true;
    _rc.actualizarRutas(ruta);
    update();

  }

  @override
  void onInit() {
    print("init state route");
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(90, 90)), 'assets/images/map.png')
        .then((onValue) {
      finish = onValue;
    });

    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(90, 90)),
            'assets/images/location.png')
        .then((onValue) {
      start = onValue;
    });
    super.onInit();
  }

  limpiar(){
    polyLines = {};
    polyPoints = [];
    puntos = [];
    markers = {};
    ruta = null;
    update();
  }


}

//Create a new class to hold the Co-ordinates we've received from the response data
class LineString {
  LineString(this.lineString);
  List<dynamic> lineString;
}