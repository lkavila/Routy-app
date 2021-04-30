import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/Domain/entities/car.dart';
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
          Container(
            child: Column(children: [
              Expanded(
                child: getVehiculos(uc.user.vehiculos, context),
              ),
            ]),
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
