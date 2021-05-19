import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/Domain/entities/routeDTO.dart';
import 'package:routy_app_v102/Presentation/GetX/dark_mode_controller.dart';
import 'package:routy_app_v102/Presentation/GetX/map_controller.dart';
import 'package:routy_app_v102/Presentation/GetX/route_controller.dart';
import 'package:routy_app_v102/Presentation/pages/map.dart';
import 'package:routy_app_v102/utils/convertir_tiempo_distancia.dart';

class RouteCard extends StatelessWidget {
  final RouteDTO ruta;
  final MapController mapC;
  const RouteCard(this.mapC,this.ruta,{Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: routeCardWidget(ruta, context),
    );
  }
  Widget routeCardWidget(RouteDTO ruta, BuildContext context) {
    final RouteController _rc = Get.find();
    final DarkModeController darkModeController = Get.find();
    final screenWidth = MediaQuery.of(context).size.width;
    final List<double> _stops = [0.0, 0.4, 1];
    return Container(
        width: screenWidth * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
        ),
        padding: EdgeInsets.fromLTRB(screenWidth*0.05, 15.0, screenWidth*0.05, 0.0),
        child: Card(
            color: Colors.grey,
            elevation: 3.0,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white70, width: 2),
              borderRadius: BorderRadius.circular(15),
            ),
            clipBehavior: Clip.antiAlias,
            child: Container(
              padding: EdgeInsets.fromLTRB(7.0, 0.0, 7.0, 0.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: darkModeController.colorsGradient(darkModeController.gradientColors),
                  stops: _stops,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "${ruta.departamentos}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      
                      GestureDetector(
                          child: Image.asset(
                            'assets/images/eliminar.png',
                            width: 20,
                            height: 40,
                          ),
                          onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
                                      title: Icon(
                                            Icons.report_outlined,
                                            color: Colors.yellow,
                                            size: 100,
                                          ),
                                      content: Text("Está seguro de querer eliminar esta ruta", style: TextStyle(color: Colors.white),),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              _rc.deleteRoute(ruta.id);
                                               Get.back();
                                            },
                                            child: Text("Si")),
                                        TextButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text("Cancelar")),
                                      ],
                                    ),
                                  );
                            
                          },
                        ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      flexibleText('Origen: ${ruta.origen}'),
                      FaIcon(FontAwesomeIcons.mapMarkedAlt, color: Colors.grey[800], size: 13,), 
                    ]),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      flexibleText('Destino: ${ruta.destino}'),
                      FaIcon(FontAwesomeIcons.mapMarkedAlt, color: Colors.grey[800], size: 13,), 
                    ]),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      flexibleText('Distancia: ${ConvertirTD.convertDistancia(ruta.distancia)}'),
                      FaIcon(FontAwesomeIcons.route, color: Colors.grey[800], size: 13,), 
                    ]),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      flexibleText('Duración: ${ConvertirTD.convertirTiempo(ruta.duracion)}'),
                      FaIcon(FontAwesomeIcons.clock, color: Colors.grey[800], size: 13,), 
                          
                    ]),


                  Align(
                    alignment: Alignment.bottomRight,
                      child: TextButton(
                          onPressed: () {
                            mapC.showChooseRouteOnMap(_rc.getRouteForMap(ruta.id));
                            mapC.tipoMenu=4;
                            Get.to(() => MyMap()); //4 significa que ya no hay que volver a crear la ruta
                          },
                          child: Text("Ver en mapa", style: TextStyle(color: Colors.indigo[900], fontSize: 15, fontWeight: FontWeight.w600),
                          ))),
                ],
              ),
            )
          
        
      )
    );
  }

  Flexible flexibleText(String text){
    return Flexible(
      child: Text(
        '$text',
        style: TextStyle(
        color: Colors.white,
        fontSize: 14.5,
        ),
        overflow: TextOverflow.fade
      ),
    );
  }
  
}