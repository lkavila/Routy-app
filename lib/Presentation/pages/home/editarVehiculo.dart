import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/Domain/entities/car.dart';
import 'package:routy_app_v102/Presentation/GetX/car_controller.dart';
import 'package:routy_app_v102/Presentation/GetX/dark_mode_controller.dart';
import 'package:routy_app_v102/Presentation/pages/home/misVehiculos.dart';
import 'package:routy_app_v102/Presentation/widgets/hidden_drawer_menu.dart';

class EditarVehiculo extends StatefulWidget {
  final CarEntity myCar;
  EditarVehiculo(this.myCar, {Key key}) : super(key: key);

  @override
  _EditarVehiculoState createState() => _EditarVehiculoState();
}

class _EditarVehiculoState extends State<EditarVehiculo> {
  List<String> tiposCombustible = ['Gasolina', 'Gas', 'Diesel','Otro'].toList();
  List<String> combistibleSelect = [];
  List<String> tiposVehiculos = ['Carro','Camión','Motocicleta','Bicicleta','A pie'].toList();
  List<String> vehiculoSelect = [];

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var nameInputController;
  var consumoInputController;
  final DarkModeController darkModeController = Get.find();
  CarEntity vehicle;
  String dropdownValue = 'Carro';
  String dropdownValueC = 'Gasolina';

  @override
  void initState() {
    nameInputController = new TextEditingController();
    consumoInputController = new TextEditingController();
    vehicle = widget.myCar;
    dropdownValue = vehicle.tipoCar;
    dropdownValueC = vehicle.tipoCombustible;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final carController = Get.put(CarController());
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editar vehículo',
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
                        "Editar vehículo",
                        style: TextStyle(
                          fontFamily: 'Pacifico',
                          fontSize: 20,
                          color: darkModeController.colorMode(),
                        ),
                      ),
                      Icon(Icons.car_repair, size: 90, color: Colors.grey,)
                      
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
                    key: Key("NombreEditarVehículo"),
                    controller: nameInputController..text = vehicle.name,
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
                    items: tiposVehiculos.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: new Text(
                          item,
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
                    items: tiposCombustible.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: new Text(
                          item,
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
                    key: Key("EditarCombustible"),
                    keyboardType: TextInputType.number,
                    controller: consumoInputController..text = vehicle.consumo.toString(),
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
                      key: Key("EditarVehiculo"),
                      onPressed: () {
                        carController.editCar(
                            vehicle.id,
                            nameInputController.text,
                            dropdownValue,
                            double.parse(consumoInputController.text),
                            dropdownValueC);
                        Get.to(() => MisVehiculos());
                      },
                      heroTag: "EditarVehiculo",
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
