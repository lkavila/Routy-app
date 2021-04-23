import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/Controllers/convertir_tiempo_distancia.dart';
import 'package:routy_app_v102/Domain/entities/route.dart';
import 'package:routy_app_v102/Presentation/GetX/car_controller.dart';
import 'package:routy_app_v102/Presentation/GetX/map_controller.dart';
import 'package:routy_app_v102/Presentation/GetX/user_controller.dart';
import 'package:routy_app_v102/Presentation/pages/home/crearVehiculo.dart';
import 'package:routy_app_v102/Presentation/pages/home/elegir_vehiculo.dart';

class Ruta extends StatelessWidget {
  const Ruta({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MapController mc = Get.find();
    final UserController uc = Get.find();
    List<String> depar;
    CarController elegido = Get.find();
    print(mc.ruta.departamentos);
    double padd = MediaQuery.of(context).size.width * 0.01;
    return Container(
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: EdgeInsets.fromLTRB(padd, padd, padd, 0),
          child: Container(
              width: MediaQuery.of(context).size.width * 0.98,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: Color.fromRGBO(131, 230, 251, 0.9),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Builder(builder: (context) {
                    if (mc.ruta.departamentos.contains(" ")) {
                      depar = mc.ruta.departamentos.split(" ");

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          FaIcon(
                            FontAwesomeIcons.mapMarkedAlt,
                            color: Colors.orange[900],
                            size: 18,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Departamentos:',
                            style: style(),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('${depar.first}', style: style2()),
                          SizedBox(
                            width: 5,
                          ),
                          FaIcon(
                            FontAwesomeIcons.arrowRight,
                            color: Colors.indigo[900],
                            size: 13,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('${depar.last}', style: style2()),
                        ],
                      );
                    } else {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          FaIcon(
                            FontAwesomeIcons.mapMarkedAlt,
                            color: Colors.orange[900],
                            size: 18,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Departamento:',
                            style: style(),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('${mc.ruta.departamentos}', style: style2()),
                        ],
                      );
                    }
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      FaIcon(
                        FontAwesomeIcons.mapMarkerAlt,
                        color: Colors.orange[900],
                        size: 18,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Origen:',
                        style: style(),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: Text(
                          '${mc.ruta.origen}',
                          style: style2(),
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      FaIcon(
                        FontAwesomeIcons.mapMarkerAlt,
                        color: Colors.orange[900],
                        size: 18,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Destino:',
                        style: style(),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: Text(
                          '${mc.ruta.destino}',
                          style: style2(),
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      FaIcon(
                        FontAwesomeIcons.route,
                        color: Colors.orange[900],
                        size: 18,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Distancia:',
                        style: style(),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: Text(
                          '${ConvertirTD.convertDistancia(mc.ruta.distancia)}',
                          style: style2(),
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      FaIcon(
                        FontAwesomeIcons.clock,
                        color: Colors.orange[900],
                        size: 18,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      texto(mc.tipoMenu, elegido.elegido),
                      SizedBox(
                        width: 5,
                      ),
                      Text('${ConvertirTD.convertirTiempo(mc.ruta.duracion)}',
                          style: style2()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      boton(mc.tipoMenu, mc.ruta, context, mc, uc),
                      GetBuilder<MapController>(builder: (_) {
                        if (mc.tipoMenu != 1) {
                          if (mc.ruta.frecuente) {
                            return IconButton(
                                icon: Icon(
                                  Icons.save,
                                  color: Colors.lightBlueAccent,
                                  size: 40,
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      title: Icon(
                                            Icons.save,
                                            color: Colors.lightBlueAccent,
                                            size: 100,
                                          ),
                                      backgroundColor:
                                          Color.fromRGBO(12, 55, 106, 0.95),
                                      content: Text("¿Esta seguro de que desea quitar esta ruta de la lista de rutas guardadas?", style: TextStyle(color: Colors.white),),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              mc.makeFrecuent();
                                              Get.back();
                                            },
                                            child: Text("Si")),
                                        TextButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text("No")),
                                        TextButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text("Cancelar")),
                                      ],
                                    ),
                                  );
                                });
                          } else {
                            return IconButton(
                                icon: Icon(
                                  Icons.save,
                                  color: Colors.grey[800],
                                  size: 40,
                                ),
                                onPressed: () {
                                  mc.makeFrecuent();
                                });
                          }
                        } else {
                          return Container();
                        }
                      })
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }

  TextStyle style() {
    return TextStyle(
        color: Color.fromRGBO(12, 55, 106, 1),
        fontSize: 14,
        fontWeight: FontWeight.w800);
  }

  TextStyle style2() {
    return TextStyle(
        color: Color.fromRGBO(12, 55, 106, 1),
        fontSize: 14,
        fontWeight: FontWeight.normal);
  }

  Text texto(int tipoMenu, String elegido) {
    if (tipoMenu == 0 || tipoMenu == 4) {
      return Text(
        'Tiempo en carro:',
        style: style(),
      );
    } else {
      return Text(
        'Tiempo en $elegido:',
        style: style(),
      );
    }
  }

  Widget boton(
      int tipoMenu, RouteEntity ruta, BuildContext context, MapController mc, UserController uc) {
    print("El tipo de menu es: " + tipoMenu.toString());
    switch (tipoMenu) {
      case 0:
        return ElevatedButton(
            onPressed: () {
                    if(uc.user.vehiculos.isNotEmpty){
                      Get.to(() => ElegirVehiculo());
                    }else{
                              showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
                                      title: Icon(
                                            Icons.taxi_alert,
                                            color: Colors.yellow,
                                            size: 100,
                                          ),
                                      backgroundColor:
                                          Color.fromRGBO(12, 55, 106, 0.95),
                                      content: Text("No tienes registrado ningún vehículo", style: TextStyle(color: Colors.white),),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              mc.makeFrecuent();
                                              Get.to(()=> CrearVehiculo());
                                            },
                                            child: Text("Crear uno")),
                                        TextButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text("Cancelar")),
                                      ],
                                    ),
                                  );
                    }
              
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith(
                    (states) => Color.fromRGBO(255, 255, 255, 0.7))),
            //style: ButtonStyle(minimumSize: MaterialStateProperty.resolveWith((state) => Size(100, 40))),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Elegir vehículo",
                      style: TextStyle(
                          color: Colors.blue[900],
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  FaIcon(FontAwesomeIcons.handPointUp, color: Colors.blue[900]),
                ]));
        break;
      case 1:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              padding: EdgeInsets.all(0),
                icon: (Icon(
                  Icons.cancel,
                  color: Colors.red,
                  size: 50,
                )),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title:Icon(Icons.cancel,color: Colors.red,size: 100, ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      backgroundColor: Color.fromRGBO(12, 55, 106, 0.95),
                      content:Text("¿Esta seguro de que desea cancelar esta ruta?", style: TextStyle(color: Colors.white)),
                      actions: [
                        TextButton(
                            onPressed: () {
                              mc.actualizarMenu(0);
                              Get.back();
                            },
                            child: Text("Si")),
                        TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text("No")),
                        TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text("Cancelar")),
                      ],
                    ),
                  );
                }),
            Padding(padding: EdgeInsets.fromLTRB(32, 5, 30, 0),
            child:
            Container(
              width: 150,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("En camino",
                        style: TextStyle(
                            color: Colors.blue[900],
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    FaIcon(FontAwesomeIcons.truckMoving,
                        color: Colors.blue[900]),
                  ]),
            ),
            ),
            IconButton(
              padding: EdgeInsets.all(0),
                icon: Icon(
                  Icons.check_circle_rounded,
                  color: Colors.green,
                  size: 50,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Icon(
                            Icons.check_circle_outline_outlined,
                            color: Colors.green,
                            size: 100,
                          ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      backgroundColor: Color.fromRGBO(12, 55, 106, 0.95),
                      content:Text("¿Esta seguro de que desea marcar como finalizada esta ruta?", style: TextStyle(color: Colors.white)),
                      actions: [
                        TextButton(
                            onPressed: () {
                              
                              mc.polyLines.clear();
                              mc.polyPoints.clear();
                              mc.puntos.clear();
                              mc.markers.clear();
                              mc.ruta = null;
                              mc.actualizarMenu(0);
                              Get.back();
                            },
                            child: Text("Si")),
                        TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text("No")),
                        TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text("Cancelar")),
                      ],
                    ),
                  ).then((value) => null);
                }),
          ],
        );
        break;
      case 2:
        return Container(
          width: 140,
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Text("Finalizado",
                style: TextStyle(
                    color: Colors.blue[900],
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            FaIcon(FontAwesomeIcons.checkDouble, color: Colors.blue[900]),
          ]),
        );
        break;

      default:
        return ElevatedButton(
            onPressed: () {
              Get.to(() => ElegirVehiculo());
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith(
                    (states) => Color.fromRGBO(255, 255, 255, 0.7))),
            //style: ButtonStyle(minimumSize: MaterialStateProperty.resolveWith((state) => Size(100, 40))),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Elegir vehículo",
                      style: TextStyle(
                          color: Colors.blue[900],
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  FaIcon(FontAwesomeIcons.handPointUp, color: Colors.blue[900]),
                ]));
    }
  }
}
