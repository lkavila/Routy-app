import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/Domain/entities/route.dart';
import 'package:routy_app_v102/Presentation/GetX/route.dart';
import 'package:routy_app_v102/Presentation/GetX/user.dart';
import 'package:routy_app_v102/Presentation/GetX/vehiculo_elegido.dart';
import 'package:routy_app_v102/models/car.dart';
import 'package:routy_app_v102/Presentation/pages/map.dart';
import 'package:routy_app_v102/Presentation/widgets/hidden_drawer_menu.dart';
import 'package:routy_app_v102/Presentation/widgets/menu_widget.dart';

class ElegirVehiculo extends StatefulWidget {
  final RouteEntity miRuta;
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
    final RouteX routeX = Get.find();
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
                    routeX.saveRoute(widget.miRuta);
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