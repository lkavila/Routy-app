import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:routy_app_v102/Controllers/crear_vehiculo.dart';
import 'package:routy_app_v102/widgets/hidden_drawer_menu.dart';
import 'package:routy_app_v102/widgets/menu_widget.dart';

class CrearVehiculo extends StatefulWidget {
  CrearVehiculo({Key key}) : super(key: key);

  @override
  _CrearVehiculoState createState() => _CrearVehiculoState();
}

class _CrearVehiculoState extends State<CrearVehiculo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final  nameInputController = new TextEditingController();
  final  consumoInputController = new TextEditingController();
  String dropdownValue = 'Carro';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerMenu(),
      body: Stack(
        children: [
          Container(
          padding: EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              Text("Crear Vehiculo", style: TextStyle(fontFamily: 'pacifico', fontSize: 25, color:  Colors.blue[700],),),

            ],
            ),

            Text("Nombre del vehiculo", style: TextStyle(color: Colors.blue[700],),textAlign: TextAlign.left,),
              TextField(
              controller: nameInputController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Ejemplo: rayo macquen',
              ),
            ),

            SizedBox(
              height: 20,
            ),

            Text("Tipo de vehiculo"),
            DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.blue),
              underline: Container(
                height: 2,
                color: Colors.indigoAccent,
              ),
              onChanged: (value) =>         
                  setState(() {
                      dropdownValue = value;
                    }),
              items: <String>['Carro', 'Camión', 'Motocicleta', 'Bicicleta', 'A pie']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            
            SizedBox(
              height: 20,
            ),

            Text("Consumo (Galones/100Km)"),
              TextField(
              keyboardType: TextInputType.number,
              controller: consumoInputController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Ejemplo: 3',
              ),
            ),

            SizedBox(
              height: 50,
            ),

            Align(
              alignment: AlignmentDirectional.topEnd,
              child: GestureDetector(
                onTap: () {
                  Crearvehiculo.crear(nameInputController.text, dropdownValue, double.parse(consumoInputController.text));
                  Navigator.pushNamed(context, "/misVehiculos");
                },
                child: Container(
                    width: 50,
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10.0, 5.0, 0, 0),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.cyan[700],
                      ),
                    child: FaIcon(FontAwesomeIcons.check, color: Colors.white, size: 30,)
                    ),
              ),
            ),
            ]
          ),
          ),

            Menu(_scaffoldKey), //este es el menu que abre el drawer


        ],
      ),
    );
  }
}