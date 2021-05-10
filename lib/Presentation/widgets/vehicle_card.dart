import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/Domain/entities/car.dart';
import 'package:routy_app_v102/Presentation/GetX/car_controller.dart';
import 'package:routy_app_v102/Presentation/GetX/dark_mode_controller.dart';
import 'package:routy_app_v102/Presentation/GetX/user_controller.dart';

class VehicleCard extends StatelessWidget {
  final CarEntity vehiculo;
  const VehicleCard(this.vehiculo, {Key key}) : super(key: key);
  
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
                  Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                    child: Text(
                      "Nombre: ${vehiculo.name}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),

                    Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 10, 5.0, 5.0),
                        child: GestureDetector(
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
                      ),
                  
                  ]
                  ),
                  
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                    child: Text(
                      'Tipo: ${vehiculo.tipoCar}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.5,
                      ),
                    ),
                  ),

                   Padding(
                    padding: EdgeInsets.fromLTRB(12.0, 0, 8.0, 5.0),
                    child:FaIcon(FontAwesomeIcons.carSide, color: Colors.grey[800], size: 13,), 
                  ),

                  ]),

                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                    child: Text(
                      'Km recorridos: ${vehiculo.recorrido}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.5,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 5.0),
                    child:FaIcon(FontAwesomeIcons.route, color: Colors.grey[800], size: 13,), 
                  ),

                  ]),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                    child: Text(
                      'Combustible consumido: ${vehiculo.consumido}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.5,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 5.0),
                    child:FaIcon(FontAwesomeIcons.weight, color: Colors.grey[800], size: 13,), 
                  )
                  ]),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                    child: Text(
                      'Tipo de Combustible: ${vehiculo.tipoCombustible}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.5,
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 5.0),
                    child:FaIcon(FontAwesomeIcons.gasPump, color: Colors.grey[800], size: 13,), 
                  )
                ]),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                    child: Text(
                      'Consumo: ${vehiculo.consumo} Galones/100Km',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.5,
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 0, 13.0, 5.0),
                    child:FaIcon(FontAwesomeIcons.tint, color: Colors.grey[800], size: 13,), 
                  )
                  ]),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
                    child: Text(
                      'Uso: ${vehiculo.uso}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.5,
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 5.0),
                    child:FaIcon(FontAwesomeIcons.clock, color: Colors.grey[800], size: 13,), 
                  )
                ],)


                ],
              ),
            )));
  }
}
