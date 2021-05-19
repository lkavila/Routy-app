import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/Domain/entities/car.dart';
import 'package:routy_app_v102/Presentation/GetX/car_controller.dart';
import 'package:routy_app_v102/Presentation/GetX/dark_mode_controller.dart';
import 'package:routy_app_v102/Presentation/GetX/user_controller.dart';
import 'package:routy_app_v102/Presentation/pages/home/crearVehiculo.dart';
import 'package:routy_app_v102/Presentation/widgets/hidden_drawer_menu.dart';
import 'package:routy_app_v102/Presentation/widgets/routes/mode_dark_switcher.dart';
import 'package:routy_app_v102/Presentation/widgets/vehicle_card.dart';

class MisVehiculos extends StatelessWidget {
  MisVehiculos({Key key}) : super(key: key);

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final UserController uc = Get.find();
  final CarController cc = Get.find();
  final DarkModeController darkModeController = Get.find();
  @override
  Widget build(BuildContext context) {
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
              icon: Icon(Icons.arrow_back_rounded, color: Colors.white,),
              label: Text("atras", style: TextStyle(color: Colors.white),))
        ],
      ),
      drawer: DrawerMenu(),
      body: Stack(
        children: [


          GetBuilder<CarController>(builder: (controller) {
            return Container(
            child: 
              GetBuilder<DarkModeController>(
              builder: (_) {
                return Column(children: [
                    
                    Expanded(
                      child: getVehiculos(uc.user.vehiculos, context),
                    ),
              ]);
              }
          )
          
          );
          }),

        ],
      ),
    );

  }
  Widget headerOptions(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FloatingActionButton(
                key: Key("Boton eliminar"),
                onPressed: () {
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
                child: Icon(
                      Icons.delete_forever,
                      color: Colors.indigo[900],
                      size: 35,
                    ),
                mini: true,
                backgroundColor: Colors.red,
                heroTag: "DeleteAllVehicles",
              ),

          GradientsSwitcher(),

          goToCrearVehiculo()

        ],);

  }

Widget goToCrearVehiculo(){
  return FloatingActionButton(
                key: Key("GoToCrearVehiculo"),
                onPressed: () {Get.to(() => CrearVehiculo());},
                child: Icon(
                      Icons.add_circle_outline,
                      color: Colors.indigo[900],
                      size: 35,
                    ),
                mini: true,
                backgroundColor: Colors.lightBlueAccent,
                heroTag: "CrearVehículo",
              );
}

  Widget getVehiculos(List<CarEntity> vehis, BuildContext context) {
    if (vehis != null && !vehis.isBlank) {
      List<Widget> list = [];

      list.add(SizedBox(height: 20,));
      list.add(headerOptions(context));
      list.add(SizedBox(height: 5,));

      vehis.sort((a, b) => b.createdAt.compareTo(a.createdAt)); //el vehiculo creado mas reciente se muestra primero
      int cont = 1;
      for (CarEntity vehi in vehis) {
        list.add(VehicleCard(vehi, cont));
        cont++;
      }
      return new ListView(children: list);
    } else {
      return Stack(

        children: [
          Center(
            child:Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.20),
          child: Text(
            "Aún no ha agregado ningun vehículo",
            style:
                TextStyle(color: darkModeController.colorMode(), fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
          ),
        
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 20, 20),
          child: goToCrearVehiculo()
          )
        )
        ]
      );

    }
  

  }
}
