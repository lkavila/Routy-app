import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/Controllers/convertir_tiempo_distancia.dart';
import 'package:routy_app_v102/Domain/entities/car.dart';
import 'package:routy_app_v102/Domain/entities/route.dart';
import 'package:routy_app_v102/Presentation/GetX/map_controller.dart';
import 'package:routy_app_v102/Presentation/GetX/route_controller.dart';
import 'package:routy_app_v102/Presentation/GetX/user_controller.dart';
import 'package:routy_app_v102/Presentation/GetX/vehiculo_elegido.dart';
import 'package:routy_app_v102/Presentation/pages/map.dart';
import 'package:routy_app_v102/Presentation/widgets/hidden_drawer_menu.dart';
import 'package:routy_app_v102/Presentation/widgets/menu_widget.dart';

class ElegirVehiculo extends StatefulWidget {
  final RouteEntity ruta;
  final int tipoMenu;
  ElegirVehiculo(this.ruta, this.tipoMenu, {Key key}) : super(key: key);

  @override
  _ElegirVehiculoState createState() => _ElegirVehiculoState();
}

class _ElegirVehiculoState extends State<ElegirVehiculo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final UserController uc = Get.find();
  String dropdown1Value;
  String dropdown2Value;
  CarEntity value1, value2;
  @override
  void initState() {
    dropdown1Value = uc.user.vehiculos.first.name;
    dropdown2Value = uc.user.vehiculos.last.name;
    value1 = uc.user.vehiculos.first;
    value2 = uc.user.vehiculos.last;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Elegido elegido = Get.find();
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
              fontSize: 25,
            ),
          ),
          actions: [
            Icon(Icons.directions_car_rounded),
            SizedBox(
              width: 20,
            ),
            TextButton.icon(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.arrow_back_rounded),
                label: Text("atras"))
          ],
        ),
        drawer: DrawerMenu(),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Comparar",
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
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Nombre del vehiculo",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'OpenSans-Bold',
                        fontSize: 18,
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DropdownButton<CarEntity>(
                        value: value1,
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.blue),
                        underline: Container(
                          height: 2,
                          color: Colors.indigoAccent,
                        ),
                        onChanged: (value) => setState(() {
                          value1 = value;
                          elegido.actualizar(value1.name);
                        }),
                        items: uc.user.vehiculos
                            .map<DropdownMenuItem<CarEntity>>(
                                (CarEntity value) {
                          return DropdownMenuItem<CarEntity>(
                            value: value,
                            child: Text(value.name),
                          );
                        }).toList(),
                      ),
                      DropdownButton<CarEntity>(
                        value: value2,
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.blue),
                        underline: Container(
                          height: 2,
                          color: Colors.indigoAccent,
                        ),
                        onChanged: (value) => setState(() {
                          value2 = value;
                        }),
                        items: uc.user.vehiculos
                            .map<DropdownMenuItem<CarEntity>>(
                                (CarEntity value) {
                          return DropdownMenuItem<CarEntity>(
                            value: value,
                            child: Text(value.name),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Distancia recorridos",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'OpenSans-Bold',
                          fontSize: 18,
                          color: Colors.blue[700],
                        ),
                      ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Consumo de combustible",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'OpenSans-Bold',
                          fontSize: 18,
                          color: Colors.blue[700],
                        ),
                      ),
                    ],
                  ),
                  Row(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Consumo de tiempo",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'OpenSans-Bold',
                          fontSize: 18,
                          color: Colors.blue[700],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Card(
                        child: Text(""),
                      ),
                      Card(
                        child: Text(""),
                      )
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (widget.tipoMenu == 0) {
                          rc.saveRoute(widget.ruta);
                        }
                        Get.to(() => MyMap());
                      },
                      child: Text("Iniciar ruta")),
                  ElevatedButton(
                      onPressed: () {
                        if (widget.tipoMenu == 0) {
                          rc.saveRoute(widget.ruta);
                        }
                        Get.to(() => MyMap());
                      },
                      child: Text("Cancelar")),
                ],
              ),
            ),
          ],
        ));
  }
}
