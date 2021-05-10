import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/utils/convertir_tiempo_distancia.dart';
import 'package:routy_app_v102/Domain/entities/car.dart';
import 'package:routy_app_v102/Presentation/GetX/car_controller.dart';
import 'package:routy_app_v102/Presentation/GetX/map_controller.dart';
import 'package:routy_app_v102/Presentation/GetX/route_controller.dart';
import 'package:routy_app_v102/Presentation/GetX/user_controller.dart';
import 'package:routy_app_v102/Presentation/pages/map.dart';
import 'package:routy_app_v102/Presentation/widgets/hidden_drawer_menu.dart';

class ElegirVehiculo extends StatefulWidget {
  ElegirVehiculo({Key key}) : super(key: key);

  @override
  _ElegirVehiculoState createState() => _ElegirVehiculoState();
}

class _ElegirVehiculoState extends State<ElegirVehiculo> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final UserController uc = Get.find();
  String dropdown1Value;
  String dropdown2Value;
  double factorVelocidad1, factorVelocidad2;
  CarEntity value1, value2;
  @override
  void initState() {
    dropdown1Value = uc.user.vehiculos.first.name;
    dropdown2Value = uc.user.vehiculos.last.name;
    value1 = uc.user.vehiculos.first;
    value2 = uc.user.vehiculos.last;
    factorVelocidad1 = asignarFactorVelocidad(uc.user.vehiculos.first.tipoCar);
    factorVelocidad2 = asignarFactorVelocidad(uc.user.vehiculos.last.tipoCar);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CarController elegido = Get.find();
    final RouteController rc = Get.find();
    final MapController mc = Get.find();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(
            'Elegir Vehiculo',
            style: TextStyle(
              fontFamily: 'pacifico',
              fontSize: 20,
            ),
          ),
          actions: [
            Icon(Icons.directions_car_rounded),
            TextButton.icon(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.arrow_back_rounded),
                label: Text("atras"))
          ],
        ),
        drawer: DrawerMenu(),
        body: Container(
              padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),),
                        Text(
                          "Comparación",
                          style: TextStyle(
                            fontFamily: 'Pacifico',
                            fontSize: 25,
                            color: Colors.blue[700],
                          ),
                        ),
                        Expanded(
                          child: Image(
                            image: AssetImage('assets/images/comparar.png'),
                            height: 100,
                          ),
                        ),
                      ],
                    ),
                  
                  Text(
                      "Nombre del vehiculo",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue[700],
                      ),
                    ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 135,
                        height: 40,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            color: Colors.lightBlue[100],
                            borderRadius: BorderRadius.circular(10)),

                        // dropdown below..
                        child: DropdownButton<CarEntity>(
                          value: value1,
                          icon: const Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 4,
                          iconDisabledColor: Colors.black,
                          iconEnabledColor: Colors.blue[900],
                          dropdownColor: Colors.lightBlueAccent[100],
                          focusColor: Colors.lightBlueAccent[100],
                          style: const TextStyle(
                            color: Colors.blue,
                          ),
                          underline: Container(
                            height: 0,
                            color: Colors.indigoAccent,
                          ),
                          onChanged: (value) => setState(() {
                            value1 = value;
                            factorVelocidad1 = asignarFactorVelocidad(value1.tipoCar);
                          }),
                          items: uc.user.vehiculos
                              .map<DropdownMenuItem<CarEntity>>(
                                  (CarEntity value) {
                            return DropdownMenuItem<CarEntity>(
                              value: value,
                              child: Text(
                                value.name,
                                style: TextStyle(
                                    color: Colors.blue[900],
                                    fontWeight: FontWeight.w900),
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      //the other dropdown
                      Container(
                        width: 135,
                        height: 40,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10)),

                        // dropdown below..
                        child: DropdownButton<CarEntity>(
                          value: value2,
                          icon: const Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 3,
                          style: const TextStyle(color: Colors.blue),
                          underline: Container(
                            height: 0,
                            color: Colors.indigoAccent,
                          ),
                          onChanged: (value) => setState(() {
                            value2 = value;
                            factorVelocidad2 =
                                asignarFactorVelocidad(value2.tipoCar);
                          }),
                          items: uc.user.vehiculos
                              .map<DropdownMenuItem<CarEntity>>(
                                  (CarEntity value) {
                            return DropdownMenuItem<CarEntity>(
                              value: value,
                              child: Text(value.name,
                                  style: TextStyle(color: Colors.black)),
                            );
                          }).toList(),
                        ),
                      )
                    ],
                  ),

                  SizedBox(height: 35,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Distancia recorrida",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue[700],
                        ),
                      ),
                      FaIcon(FontAwesomeIcons.route, color: Colors.grey[700]), 
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Card(
                        child: Text(
                            ConvertirTD.convertDistancia(value1.recorrido)),
                      ),
                      Card(
                        child: Text(
                            ConvertirTD.convertDistancia(value2.recorrido)),
                      )
                    ],
                  ),

                  SizedBox(height: 35,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Consumo de combustible",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue[700],
                        ),
                      ),
                      FaIcon(FontAwesomeIcons.gasPump, color: Colors.grey[700]), 
                    ],
                  ),

                  Builder(builder: (_){
                    if(mc.ruta!=null){
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Card(
                        child: Text(((value1.consumo / 100) *
                                    (mc.ruta.distancia / 1000))
                                .toStringAsFixed(3) +
                            " Galones"),
                      ),
                      Card(
                        child: Text(((value2.consumo / 100) *
                                    (mc.ruta.distancia / 1000))
                                .toStringAsFixed(3) +
                            " Galones"),
                      )
                    ],
                  ),

                  SizedBox(height: 35,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Consumo de tiempo",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue[700],
                        ),
                      ),
                      FaIcon(FontAwesomeIcons.clock, color: Colors.grey[700]), 
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Card(
                        child: Text(ConvertirTD.convertirTiempo(
                            mc.ruta.duracion * factorVelocidad1)),
                      ),
                      Card(
                        child: Text(ConvertirTD.convertirTiempo(
                            mc.ruta.duracion * factorVelocidad2)),
                      )
                    ],
                  ),

                  SizedBox(height: 35,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  ElevatedButton(
                      onPressed: () {
                        if (mc.tipoMenu == 0) {
                          rc.saveRoute(mc.ruta);
                        }
                        mc.tipoMenu=1;
                        elegido.actualizar(value1.name);
                        Get.to(() => MyMap());
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => Colors.lightBlueAccent)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Iniciar ruta",
                                style: TextStyle(
                                    color: Colors.blue[900],
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            FaIcon(FontAwesomeIcons.playCircle,
                                color: Colors.blue[900]),
                          ]
                          )
                          ),

                    ElevatedButton(
                      onPressed: () {
                        Get.to(() => MyMap());
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => Color.fromRGBO(255, 255, 255, 0.7))),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Cancelar",
                                style: TextStyle(
                                    color: Colors.blue[900],
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            Icon(Icons.cancel, color: Colors.red),
                          ])),
                    ],
                  )
                  
                        ],
                      );
                    }else{return Text("No existe una ruta actual");}
                  }),

                  
                ],
              ),
            ),
          );
  }

  asignarFactorVelocidad(String tipoCar) {
    double factorVelocidad;
    switch (tipoCar) {
      case "Carro":
        factorVelocidad = 1;
        break;
      case "Camión":
        factorVelocidad = 1.55;
        break;
      case "Motocicleta":
        factorVelocidad = 0.66;
        break;
      case "Bicicleta":
        factorVelocidad = 1.5;
        break;
      case "A pie":
        factorVelocidad = 10;

        break;
      default:
        factorVelocidad = 1;
        break;
    }
    return factorVelocidad;
  }
}
