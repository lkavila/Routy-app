import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/GetX/user.dart';
import 'package:routy_app_v102/models/car.dart';
import 'package:routy_app_v102/widgets/hidden_drawer_menu.dart';
import 'package:routy_app_v102/widgets/menu_widget.dart';

class MisVehiculos extends StatelessWidget {
  MisVehiculos({Key key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final UserX userx = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      drawer: DrawerMenu(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Mis Vehiculos",
                    style: TextStyle(
                      fontFamily: 'pacifico',
                      fontSize: 25,
                      color: Colors.blue[700],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: getVehiculos(userx.myUser.vehiculos),
              ),
            ]),
          ),

          Menu(_scaffoldKey), //este es el menu que abre el drawer
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/crearVehiculo");
                },
                child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.indigo[900],
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.plusCircle,
                      color: Colors.blue,
                      size: 40,
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getVehiculos(List<Car> vehis) {
    print(vehis);
    if (vehis != null && !vehis.isBlank) {
      List<Widget> list = [];
      for (Car vehi in vehis) {
        list.add(carWidget(vehi.name, vehi.tipoCar, vehi.recorrido,
            vehi.consumido, vehi.uso, vehi.consumo));
      }
      return new ListView(children: list);
    } else {
      return Container(
        width: 170,
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 150, 0, 0),
          child: Text(
            "Aún no ha agregado ningún vehículo",
            style: TextStyle(color: Colors.blue[700], fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  Widget carWidget(String name, String tipo, double recorrido, double consumido,
      double uso, double consumo) {
    final List<Color> _colors = [Colors.blue, Colors.cyan[400]];
    final List<double> _stops = [0.4, 1];
    return Container(
        width: 400,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
        ),
        padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
        child: Card(
            color: Colors.grey,
            elevation: 3.0,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey[350], width: 2),
              borderRadius: BorderRadius.circular(15),
            ),
            clipBehavior: Clip.antiAlias,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: _colors,
                  stops: _stops,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      "Nombre: $name",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      'Tipo: $tipo',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                    child: Text(
                      'Kilometros recorridos: $recorrido',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                    child: Text(
                      'Combustible consumido: $consumido',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                    child: Text(
                      'Consumo: $consumo Galones/100Km',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                    child: Text(
                      'Uso: $uso',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
