import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  GoogleMapController mapController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  @override
  void initState() {
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
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: const LatLng(10.90352, -74.79463),
              zoom: 15,
            ),
            onTap: (data) {
              routeX.createMarkers(data.latitude, data.longitude);
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
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 40, 10, 0),
            child: Container(
              width: 95,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color.fromRGBO(131, 230, 251, 0.5),
              ),
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      routeX.polyLines.clear();
                      routeX.polyPoints.clear();
                      routeX.puntos.clear();
                      routeX.markers.clear();
                      routeX.ruta = null;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FaIcon(FontAwesomeIcons.broom, color: Colors.indigo),
                      Text(
                        'Limpiar',
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
            ),
          ),
        ),

        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 30),
            child: Container(
              width: 160,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color.fromRGBO(131, 230, 251, 0.5),
              ),
              child: GestureDetector(
                  onTap: () {
                    if (routeX.puntos.length > 1) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: Color.fromRGBO(12, 55, 106, 0.95),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
                          title: Text("¿Ruta circular?", style: TextStyle(color: Colors.white)),
                          content: Text(
                              "Despues de llegar al final ¿regresará al inicio?", style: TextStyle(color: Colors.white)),
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
                          backgroundColor: Color.fromRGBO(12, 55, 106, 0.95),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
                          title: Text("No hay suficientes puntos", style: TextStyle(color: Colors.white)),
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
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FaIcon(FontAwesomeIcons.route, color: Colors.indigo),
                      Text(
                        'Ver ruta óptima',
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
            ),
          ),
        ),

        GetBuilder<MapController>(builder: (_) {
          if (routeX.ruta != null) {
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
}
