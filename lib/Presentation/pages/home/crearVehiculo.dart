import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/Presentation/GetX/car_controller.dart';
import 'package:routy_app_v102/Presentation/pages/home/misVehiculos.dart';
import 'package:routy_app_v102/Presentation/widgets/hidden_drawer_menu.dart';

class CrearVehiculo extends StatefulWidget {
  CrearVehiculo({Key key}) : super(key: key);

  @override
  _CrearVehiculoState createState() => _CrearVehiculoState();
}

class _CrearVehiculoState extends State<CrearVehiculo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final nameInputController = new TextEditingController();
  final consumoInputController = new TextEditingController();
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
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
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
                          color: Colors.blue[700],
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
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  TextField(
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
                        color: Colors.blue[700],
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
                      color: Colors.blue[700],
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
                            color: Colors.blue[700],
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
                        color: Colors.blue[700],
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
                      color: Colors.blue[700],
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
                            color: Colors.blue[700],
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
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  TextField(
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
                    child: GestureDetector(
                      onTap: () {
                        carController.createCar(
                            nameInputController.text,
                            dropdownValue,
                            double.parse(consumoInputController.text),
                            dropdownValueC);
                        Get.to(() => MisVehiculos());
                      },
                      child: Container(
                          width: 50,
                          height: 50,
                          padding: EdgeInsets.fromLTRB(10.0, 5.0, 0, 0),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromRGBO(0, 128, 0, 20)),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green,
                          ),
                          child: FaIcon(
                            FontAwesomeIcons.check,
                            color: Colors.white,
                            size: 30,
                          )),
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
