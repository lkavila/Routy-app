import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/Controllers/crear_ruta.dart';
import 'package:routy_app_v102/GetX/user.dart';
import 'package:routy_app_v102/GetX/vehiculo_elegido.dart';
import 'package:routy_app_v102/models/car.dart';
import 'package:routy_app_v102/models/route.dart';
import 'package:routy_app_v102/screens/map.dart';
import 'package:routy_app_v102/widgets/hidden_drawer_menu.dart';
import 'package:routy_app_v102/widgets/menu_widget.dart';

class ElegirVehiculo extends StatefulWidget {
  final MyRoute miRuta;
  final int tipoMenu;
  ElegirVehiculo(this.miRuta, this.tipoMenu, {Key key}) : super(key: key);
  

  @override
  _ElegirVehiculoState createState() => _ElegirVehiculoState();
}

class _ElegirVehiculoState extends State<ElegirVehiculo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final UserX userx = Get.find();
    final Elegido elegido = Get.find();
    String dropdown1Value = userx.myUser.vehiculos.first.name;
    String dropdown2Value = userx.myUser.vehiculos.last.name;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      drawer: DrawerMenu(),
      body: Stack(
        children: [
          Container(
        padding: EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
        child: Column(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [

           Row(
             mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: [
              DropdownButton<String>(
              value: dropdown1Value,
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
                      dropdown1Value = value;
                      elegido.actualizar(dropdown1Value);
                    }),
             items: userx.myUser.vehiculos.map<DropdownMenuItem<String>>((Car value) {
                return DropdownMenuItem<String>(
                  value: value.name,
                  child: Text(value.name),
                );
              }).toList(),
              
              ),

           DropdownButton<String>(
              value: dropdown2Value,
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
                      dropdown2Value = value;
                    }),
             items: userx.myUser.vehiculos.map<DropdownMenuItem<String>>((Car value) {
                return DropdownMenuItem<String>(
                  value: value.name,
                  child: Text(value.name),
                );
              }).toList(),)

           ],
           ),

           ElevatedButton(
             onPressed:(){
                if (widget.tipoMenu==0){
                    CrearRuta.crear(widget.miRuta);
                }
                Get.to(MyMap(widget.miRuta, 1));
                  }, 
           child: Text("Iniciar ruta")),

          ],
          ),
          ),
          
            Menu(_scaffoldKey), //este es el menu que abre el drawer
          
        ],
      )
    );
  }
}