import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/Controllers/crear_ruta.dart';
import 'package:routy_app_v102/GetX/user.dart';
import 'package:routy_app_v102/GetX/vehiculo_elegido.dart';
import 'package:routy_app_v102/models/car.dart';
import 'package:routy_app_v102/models/route.dart';
import 'package:routy_app_v102/screens/map.dart';

class ElegirVehiculo extends StatefulWidget {
  final MyRoute miRuta;
  final int tipoMenu;
  ElegirVehiculo(this.miRuta, this.tipoMenu, {Key key}) : super(key: key);

  @override
  _ElegirVehiculoState createState() => _ElegirVehiculoState();
}

class _ElegirVehiculoState extends State<ElegirVehiculo> {
  @override
  Widget build(BuildContext context) {
    final UserX userx = Get.find();
    final Elegido elegido = Get.find();
    Car dropdown1Value = userx.myUser.vehiculos.first;
    Car dropdown2Value = userx.myUser.vehiculos.first;
    return Container(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [

           Row(
             mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: [
                          DropdownButton(
              value: dropdown1Value.name,
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
                      elegido.actualizar(dropdown1Value.name);
                    }),
             items: userx.myUser.vehiculos.map<DropdownMenuItem<Car>>((Car value) {
                return DropdownMenuItem<Car>(
                  value: value,
                  child: Text(value.name),
                );
              }).toList(),
              
              ),

           DropdownButton(
              value: dropdown2Value.name,
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
             items: userx.myUser.vehiculos.map<DropdownMenuItem<Car>>((Car value) {
                return DropdownMenuItem<Car>(
                  value: value,
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
                Get.to(MyMap(widget.miRuta, widget.tipoMenu));
                  }, 
           child: Text("Continuar")),

         ],
       ),
    );
  }
}