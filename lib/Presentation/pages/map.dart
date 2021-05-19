import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:routy_app_v102/Presentation/GetX/location_controller.dart';
import 'package:routy_app_v102/Presentation/GetX/map_controller.dart';
import 'package:routy_app_v102/Presentation/widgets/hidden_drawer_menu.dart';
import 'package:routy_app_v102/Presentation/widgets/loading_widget.dart';
import 'package:routy_app_v102/Presentation/widgets/menu_widget.dart';
import 'package:routy_app_v102/Presentation/widgets/ruta_widget.dart';

class MyMap extends StatefulWidget {
  const MyMap({Key key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyMap> {
  final MapController routeX = Get.find();
  final _locationController = Get.put(LocationController());
  GoogleMapController mapController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState(){
    _locationController.requestGPS();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerMenu(),
      body: Stack(children: [
        GetBuilder<MapController>(
          builder: (_) => GoogleMap(
            key: Key("Mapa"),
            onMapCreated: _onMapCreated,
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
            trafficEnabled: routeX.trafficMode,
            initialCameraPosition: CameraPosition(
              target: const LatLng(10.90352, -74.79463),
              zoom: 13,
            ),
            onTap: (data) {
              routeX.createMarkerFromTap(data.latitude, data.longitude, routeX.markerImage(), routeX.markers.length);
              print(routeX.markers.last.position);
              if (routeX.polyLines.isNotEmpty) {
                setState(() {
                  routeX.polyLines.clear();
                  routeX.polyPoints.clear();
                  routeX.ruta = null;
                });
              }
            },
            markers: routeX.markers,
            polylines: routeX.polyLines,
          ),
        ),


        Align(
              alignment: Alignment.centerRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GetBuilder<MapController>(
                    builder: (_) => 
                     FloatingActionButton(
                       key: Key("Ver ruta optima"),
                       mini: true,
                      onPressed: (){
                        if(routeX.ruta!=null){
                          //si ya existe una ruta no hace nada
                        }else{
                      if (routeX.ruta==null && routeX.puntos.length > 1) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          title: Text("¿Ruta circular?",
                              style: TextStyle(color: Colors.white)),
                          content: Text(
                              "Despues de llegar al final ¿regresará al inicio?",
                              style: TextStyle(color: Colors.white)),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                },
                                child: Text("Si")),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                                child: Text("No")),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(null);
                                },
                                child: Text("Cancelar"))
                          ],
                        ),
                      ).then((value) {
                        if (value != null) {
                          print("La opcion tomada fue: " + value.toString());
                          routeX.createRoute(value.toString());
                          print(routeX.polyPoints);
                        } else {
                          print("La opcion tomada fue: Cancelar ");
                        }
                      });
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          key: Key("Not Enough Routes"),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          title: Text("No hay suficientes puntos",
                              style: TextStyle(color: Colors.white)),
                          content: Text(
                              "Para poder calcular la mejor ruta debe haber al menos 2 puntos, para crear puntos debe hacer tap sobre el mapa",
                              style: TextStyle(color: Colors.white)),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("OK"))
                          ],
                        ),
                      );
                      
                      }
                    }
                    } ,
                    heroTag: "verRutaOptima",
                    tooltip: routeX.ruta!=null ? 'la ruta ya fue calculada' : 'Calcular ruta óptima entre los puntos',
                    child: routeX.ruta!=null ? FaIcon(FontAwesomeIcons.route, color: Colors.grey[900], size: 20,) : new FaIcon(FontAwesomeIcons.route, color: Colors.white, size: 20,),
                ),
                ),
                  SizedBox(height: 10),
                  FloatingActionButton(
                    onPressed: _followMe,
                    heroTag: "ubicarme",
                    mini: true,
                    tooltip: "Ver mi posición actual",
                    child: Icon(Icons.gps_fixed, size: 25,)
                    ),

                  SizedBox(height: 10),
                  GetBuilder<MapController>(
                  builder: (_) =>
                      FloatingActionButton(
                        onPressed: (){
                        routeX.actualizarTrafficMode();
                      },
                      heroTag: "activarTrafico",
                      tooltip: "Ver el trafico en tiempo real",
                      mini: true,
                      child: routeX.trafficMode ? 
                        FaIcon(FontAwesomeIcons.trafficLight, color: Colors.grey[900], size: 20,) :
                        FaIcon(FontAwesomeIcons.trafficLight, color: Colors.white, size: 20,)),
                  ),

                  SizedBox(height: 10),
                  FloatingActionButton(
                    onPressed: (){
                      routeX.limpiar();
                      routeX.actualizarMenu(0);
                      _locationController.stopLocationStream();
                    },
                  heroTag: "limpiarPantalla",
                  tooltip: "Limpiar pantalla/Quitar ruta",
                  mini: true,
                  child: FaIcon(FontAwesomeIcons.broom, color: Colors.white, size: 20,),)
                  
                  ],
                )
            ),

        GetBuilder<MapController>(builder: (_) {
          if (!routeX.cargandoPolylines.value && routeX.ruta != null) {
            return Ruta();
          } else {
            return SizedBox();
          }
        }),

        Obx(() {
          if (routeX.cargandoPolylines.value) {
            return Loading("Calculando ruta...");
          } else {
            return SizedBox();
          }
        }),

        Menu(_scaffoldKey), //este es el menu que abre el drawer
      ]),
    );


  }

  Future<void> _followMe() async {
    CameraPosition _kLake = new CameraPosition(
      target: LatLng(_locationController.location.latitud, _locationController.location.longitud),
      zoom: 15);
    mapController.animateCamera(CameraUpdate.newCameraPosition(_kLake));

  }

}
