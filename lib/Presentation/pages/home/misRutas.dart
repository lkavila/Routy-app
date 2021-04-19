import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/Controllers/convertir_tiempo_distancia.dart';
import 'package:routy_app_v102/Domain/entities/route.dart';
import 'package:routy_app_v102/Presentation/GetX/map_route_controller.dart';
import 'package:routy_app_v102/Presentation/GetX/vehiculo_elegido.dart';
import 'package:routy_app_v102/Presentation/pages/map.dart';
import 'package:routy_app_v102/Presentation/widgets/hidden_drawer_menu.dart';
import 'package:routy_app_v102/Presentation/widgets/loading_widget.dart';
import 'package:routy_app_v102/Presentation/widgets/menu_widget.dart';

class MisRutas extends StatelessWidget {
  MisRutas({Key key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final RouteController routeX = Get.find();

  @override
  Widget build(BuildContext context) {
    Get.put(Elegido());
    return Scaffold(
        key: _scaffoldKey,
        drawer: DrawerMenu(),
        body: GetBuilder<RouteController>(
          builder: (_) {
            print("hay rutas?");
            if (routeX.cargandoRutas.value) {
              return Loading("Cargando mis rutas...");
            } else
              return Stack(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Mis Rutas",
                            style: TextStyle(
                              fontFamily: 'pacifico',
                              fontSize: 25,
                              color: Colors.blue[800],
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        flex: 2,
                        child: getRutas(routeX.misRutas, context),
                      ),
                    ]),
                  ),
                  Menu(_scaffoldKey), //este es el menu que abre el drawer
                ],
              );
          },
        ));
  }

  Widget getRutas(List<RouteEntity> rutas, BuildContext context) {
    List<Widget> list = [];
    rutas.forEach((ruta) {
      list.add(carWidget(ruta, context));
    });
    return new ListView(
      padding: EdgeInsets.only(top: 0.0),
      children: list,
    );
  }

  Widget carWidget(RouteEntity ruta, BuildContext context) {
    final List<Color> _colors = [
      Colors.indigo[900],
      Colors.blue[800],
      Colors.cyanAccent[400]
    ];
    final List<double> _stops = [0.0, 0.4, 1];
    return Container(
        width: 350,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
        ),
        padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
        child: Expanded( flex: 1, child: 
          Card(
            color: Colors.grey,
            elevation: 3.0,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white70, width: 2),
              borderRadius: BorderRadius.circular(15),
            ),
            clipBehavior: Clip.antiAlias,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: _colors,
                  stops: _stops,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 10.0, 15.0, 0.0),
                        child: Text(
                          "${ruta.departamentos}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 0.0),
                        child: GestureDetector(
                          child: Image.asset(
                            'assets/images/eliminar.png',
                          ),
                          onTap: () {},
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 0.0, 15.0, 0.0),
                    child: Text(
                      'Origen: ${ruta.origen}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.5,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 0.0, 15.0, 0.0),
                    child: Text(
                      'Destino: ${ruta.destino}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.5,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 0.0, 15.0, 0.0),
                    child: Text(
                      'Distancia: ${ConvertirTD.convertDistancia(ruta.distancia)}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.5,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 0.0, 15.0, 0.0),
                    child: Text(
                      'Duración: ${ConvertirTD.convertirTiempo(ruta.duracion)}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.5,
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.55,
                          0.0,
                          0.0,
                          0.0),
                      child: TextButton(
                          onPressed: () {
                            routeX.showChooseRouteOnMap(ruta);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyMap()),
                            ); //4 significa que ya no hay que volver a crear la ruta
                          },
                          child: Text(
                            "Ver en mapa",
                            style: TextStyle(
                                color: Colors.indigo[900], fontSize: 15),
                          )))
                ],
              ),
            )
          )
        )
      );
  }
}
