import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/Domain/entities/car.dart';
import 'package:routy_app_v102/Presentation/GetX/car_controller.dart';
import 'package:routy_app_v102/Presentation/GetX/user_controller.dart';
import 'package:routy_app_v102/Presentation/pages/home/crearVehiculo.dart';
import 'package:routy_app_v102/Presentation/widgets/hidden_drawer_menu.dart';
import 'package:routy_app_v102/Presentation/widgets/vehicle_card.dart';

class MisVehiculos extends StatelessWidget {
  MisVehiculos({Key key}) : super(key: key);
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final UserController uc = Get.find();
    final CarController cc = Get.find();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Mis vehículos',
          style: TextStyle(
            fontFamily: 'pacifico',
            fontSize: 20,
          ),
        ),
        actions: [
          Icon(Icons.directions_car_rounded),
          TextButton.icon(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back_rounded),
              label: Text("atras"))
        ],
      ),
      drawer: DrawerMenu(),
      body: Stack(
        children: [


          GetBuilder<CarController>(builder: (controller) {
            return Container(
            child: Column(children: [
              Expanded(
                child: getVehiculos(uc.user.vehiculos, context),
              ),
            ]),
          );
          }
          ),


          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 20.0),
              child: GestureDetector(
                onTap: () {
                  Get.to(() => CrearVehiculo());
                },
                child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.lightBlueAccent,
                    ),
                    child: Icon(
                      Icons.add_circle_outline,
                      color: Colors.indigo[900],
                      size: 40,
                    )),
              ),
            ),
          ),

        Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 20.0),
              child: GestureDetector(
                key: Key("Boton eliminar"),
                onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      key: Key("Eliminar todos alert"),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
                                      title: Icon(
                                            Icons.taxi_alert,
                                            color: Colors.orange[900],
                                            size: 100,
                                          ),
                                      content: Text("¿Está seguro de querer eliminar todos los vehículos? Luego no podrá recuperarlos", style: TextStyle(color: Colors.white),),
                                      actions: [
                                        TextButton(
                                          key: Key("Eliminar todos"),
                                            onPressed: () {
                                              uc.deleteAllCarsFromList();
                                              cc.deleteAllCars(uc.user.id);
                                              Get.back();
                                            },
                                            child: Text("Si, eliminar")),
                                        TextButton(

                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text("Cancelar")),
                                      ],
                                    ),
                                  );
                },
                child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: Icon(
                      Icons.delete_forever,
                      color: Colors.indigo[900],
                      size: 40,
                    )),
              ),
            ),
          )


        ],
      ),
    );
  }

  Widget getVehiculos(List<CarEntity> vehis, BuildContext context) {
    if (vehis != null && !vehis.isBlank) {
      List<Widget> list = [];
      for (CarEntity vehi in vehis) {
        list.add(VehicleCard(vehi));
      }
      return new ListView(children: list);
    } else {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.20),
          child: Text(
            "Aún no ha agregado ningún vehículo",
            style: TextStyle(color: Colors.blue[800], fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }
}
