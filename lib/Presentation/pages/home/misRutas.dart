import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/Presentation/GetX/car_controller.dart';
import 'package:routy_app_v102/Presentation/GetX/dark_mode_controller.dart';
import 'package:routy_app_v102/Presentation/GetX/map_controller.dart';
import 'package:routy_app_v102/Presentation/widgets/hidden_drawer_menu.dart';
import 'package:routy_app_v102/Presentation/widgets/routes/histrorical_routes.dart';
import 'package:routy_app_v102/Presentation/widgets/routes/saved_routes.dart';

class MisRutas extends StatelessWidget {
  MisRutas({Key key}) : super(key: key);
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  
  @override
  Widget build(BuildContext context) {
    Get.put(MapController());
    Get.put(CarController());
    Get.put(DarkModeController());
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.save)),
                Tab(icon: Icon(Icons.watch_later_rounded)),
              ],
            ),
            actions: [
              Icon(Icons.alt_route_rounded),
              TextButton.icon(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.arrow_back_rounded, color: Colors.white,),
                  label: Text("atras", style: TextStyle(color: Colors.white)))
            ],
            title: Text(
              'Mis rutas',
              style: TextStyle(
                fontFamily: 'pacifico',
                fontSize: 25,
              ),
            ),
          ),
          key: _scaffoldKey,
          drawer: DrawerMenu(),
          body: TabBarView(
            children: [
              //primer tab
              SavedRoutes(),

              //segundo tab
              HistoricalRoutes()
            ],
          )),
    );
  }
}
