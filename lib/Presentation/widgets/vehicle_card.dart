import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/Domain/entities/car.dart';
import 'package:routy_app_v102/Presentation/GetX/car_controller.dart';
import 'package:routy_app_v102/Presentation/GetX/dark_mode_controller.dart';
import 'package:routy_app_v102/Presentation/GetX/user_controller.dart';
import 'package:routy_app_v102/Presentation/pages/home/editarVehiculo.dart';

class VehicleCard extends StatelessWidget {
  final CarEntity vehiculo;
  final int numVehiculo;
  const VehicleCard(this.vehiculo, this.numVehiculo, {Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: carWidget(vehiculo, context),
    );
  }

  Widget carWidget(CarEntity vehiculo, BuildContext context) {
    final CarController carController = Get.find();
    final UserController userController = Get.find();
    final DarkModeController _darkModeController = Get.find();
    final List<double> _stops = [0.0, 0.44, 1];
    return Container(
        width: MediaQuery.of(context).size.width * 0.90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
        ),
        padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
        child: Card(
            color: Colors.grey,
            elevation: 3.0,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey[350], width: 2),
              borderRadius: BorderRadius.circular(15),
            ),
            clipBehavior: Clip.antiAlias,
            child: Container(
              padding: EdgeInsets.fromLTRB(7.0, 5.0, 7.0, 0.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: _darkModeController.colorsGradient(_darkModeController.gradientColors),
                  stops: _stops,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child:Text(
                              "Nombre: ${vehiculo.name}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                                  overflow: TextOverflow.fade
                            ),
                        ),
                  

                    GestureDetector(
                          child: Image.asset(
                            'assets/images/eliminar.png',
                            width: 20,
                            height: 40,
                          ),
                          onTap: () {

                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
                                      title: Icon(
                                            Icons.taxi_alert,
                                            color: Colors.yellow,
                                            size: 100,
                                          ),
                                      content: Text("¿Está seguro de querer eliminar este vihículo?", style: TextStyle(color: Colors.white),),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              userController.deleteCarFromList(vehiculo.id);
                                              carController.deleteCar(vehiculo.id);
                                               Get.back();
                                            },
                                            child: Text("Si")),
                                        TextButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text("Cancelar")),
                                      ],
                                    ),
                                  );
                            
                          },
                        ),
                  ]
                  ),
                  
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  flexibleText('Tipo de vehículo: ${vehiculo.tipoCar}'),
                  FaIcon(FontAwesomeIcons.carSide, color: Colors.grey[800], size: 13,), 
                  ]),

                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   flexibleText('Recorrido: ${vehiculo.recorrido}'),
                   FaIcon(FontAwesomeIcons.route, color: Colors.grey[800], size: 13,), 
                  ]),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    flexibleText('Combustible consumido: ${vehiculo.consumido}'),
                    FaIcon(FontAwesomeIcons.weight, color: Colors.grey[800], size: 13,), 
                  ]),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    flexibleText('Tipo de Combustible: ${vehiculo.tipoCombustible}'),
                    FaIcon(FontAwesomeIcons.gasPump, color: Colors.grey[800], size: 13,), 
                ]),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  
                    flexibleText('Consumo: ${vehiculo.consumo} Galones/100Km'),
                    FaIcon(FontAwesomeIcons.tint, color: Colors.grey[800], size: 13,), 
                  ]),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    flexibleText('Uso del vehículo: ${vehiculo.uso}'),
                    FaIcon(FontAwesomeIcons.clock, color: Colors.grey[800], size: 13,), 
                ],),


                 Align(
                    alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            key: Key("editarVehiculo"+numVehiculo.toString()),
                          onPressed: () {
                            Get.to(() => EditarVehiculo(vehiculo)); //4 significa que ya no hay que volver a crear la ruta
                          },
                          child: Text("Editar vehículo", style: TextStyle(color: Colors.indigo[900], fontSize: 15, fontWeight: FontWeight.w600),
                            )),
                          Icon(Icons.settings, color: Colors.grey[800], size: 15,),
                        ])
                          ),
                ],

              ),
            )
            )
            );
  }
Flexible flexibleText(String text){
    return Flexible(
      child: Text(
        '$text',
        style: TextStyle(
        color: Colors.white,
        fontSize: 14.5,
        ),
        overflow: TextOverflow.fade
      ),
    );
  }
}
