import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/Presentation/GetX/car_controller.dart';
import 'package:routy_app_v102/Presentation/GetX/dark_mode_controller.dart';
import 'package:routy_app_v102/Presentation/pages/home/misVehiculos.dart';
import 'package:routy_app_v102/Presentation/widgets/hidden_drawer_menu.dart';

class CrearVehiculo extends StatefulWidget {
  CrearVehiculo({Key key}) : super(key: key);

  @override
  _CrearVehiculoState createState() => _CrearVehiculoState();
}

class _CrearVehiculoState extends State<CrearVehiculo> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final nameInputController = new TextEditingController();
  final consumoInputController = new TextEditingController();
  final DarkModeController darkModeController = Get.find();
  String dropdownValue = 'Carro';
  String dropdownValueC = 'Gasolina';
  @override
  Widget build(BuildContext context) {
    final carController = Get.put(CarController());
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Crear vehículo',
          style: TextStyle(
            fontFamily: 'pacifico',
            fontSize: 20,
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      drawer: DrawerMenu(),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Agregar Vehículo",
                        style: TextStyle(
                          fontFamily: 'Pacifico',
                          fontSize: 25,
                          color: darkModeController.colorMode(),
                        ),
                      ),
                      Expanded(
                        child: Image(
                          image: AssetImage('assets/images/camioneta.png'),
                          height: 90,
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
                        fontSize: 15,
                        color: darkModeController.colorMode()
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    key: Key("NombreVehículo"),
                    controller: nameInputController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      labelText: 'Ejemplo: rayo macquen',
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Tipo de vehiculo",
                      style: TextStyle(
                        fontSize: 15,
                        color: darkModeController.colorMode(),
                      ),
                    ),
                  ),
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward,
                        color: Color.fromRGBO(25, 118, 210, 20)),
                    iconSize: 24,
                    elevation: 3,
                    style: const TextStyle(color: Colors.blue),
                    underline: Container(
                      height: 2,
                      width: 20,
                      
                    ),
                    onChanged: (value) => setState(() {
                      dropdownValue = value;
                    }),
                    items: <String>[
                      'Carro',
                      'Camión',
                      'Motocicleta',
                      'Bicicleta',
                      'A pie'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            fontSize: 14,
                            color: darkModeController.colorMode(),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Tipo de Combustible",
                      style: TextStyle(
                        fontSize: 15,
                        color: darkModeController.colorMode(),
                      ),
                    ),
                  ),
                  DropdownButton<String>(
                    value: dropdownValueC,
                    icon: const Icon(Icons.arrow_downward,
                        color: Color.fromRGBO(25, 118, 210, 20)),
                    iconSize: 24,
                    elevation: 3,
                    style: const TextStyle(color: Colors.blue),
                    underline: Container(
                      height: 2,
                      width: 20,
                      
                    ),
                    onChanged: (value) => setState(() {
                      dropdownValueC = value;
                    }),
                    items: <String>[
                      'Gasolina',
                      'Gas',
                      'Diesel',
                      'Otro',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            fontSize: 14,
                            color: darkModeController.colorMode(),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Consumo (Galones/100Km)",
                      style: TextStyle(
                        fontSize: 15,
                        color: darkModeController.colorMode(),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    key: Key("Combustible"),
                    keyboardType: TextInputType.number,
                    controller: consumoInputController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      labelText: 'Ejemplo: 3',
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: FloatingActionButton(
                      key: Key("CrearNuevoVehiculo"),
                      onPressed: () {
                        carController.createCar(
                            nameInputController.text,
                            dropdownValue,
                            double.parse(consumoInputController.text),
                            dropdownValueC);
                        Get.to(() => MisVehiculos());
                      },
                      heroTag: "CrearNuevoVehiculo",
                      mini: true,
                      backgroundColor: Colors.green,
                      child: FaIcon(
                            FontAwesomeIcons.check,
                            color: Colors.white,
                            size: 27,
                          )
                    ),
                  ),
                ]),
          ),

          //Menu(_scaffoldKey), //este es el menu que abre el drawer
        ],
      ),
    );
  }
}
