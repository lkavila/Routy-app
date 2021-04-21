import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/Domain/entities/route.dart';
import 'package:routy_app_v102/Presentation/GetX/map_controller.dart';
import 'package:routy_app_v102/Presentation/GetX/route_controller.dart';
import 'package:routy_app_v102/Presentation/GetX/vehiculo_elegido.dart';
import 'package:routy_app_v102/Presentation/pages/map.dart';
import 'package:routy_app_v102/Presentation/widgets/hidden_drawer_menu.dart';
import 'package:routy_app_v102/Presentation/widgets/loading_widget.dart';
import 'package:routy_app_v102/Presentation/widgets/route_card.dart';

class MisRutas extends StatelessWidget {
  MisRutas({Key key}) : super(key: key);

  final mapC = Get.put(MapController());
  @override
  Widget build(BuildContext context) {
    Get.put(Elegido());
    final RouteController routeX = Get.find();
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
            SizedBox(
              width: 20,
            ),
            TextButton.icon(onPressed: (){
              Get.back();
            }, icon: Icon(Icons.arrow_back_rounded), label: Text("atras"))
          ],
            title: Text(
              'Mis rutas',
              style: TextStyle(
                fontFamily: 'pacifico',
                fontSize: 25,
              ),
            ),
          ),
          drawer: DrawerMenu(),
          body: TabBarView(
            children: [
              //primer tab
              Icon(Icons.watch),

              //segundo tab
              GetBuilder<RouteController>(
                builder: (_) {
                  print("hay rutas?");
                  if (routeX.cargandoRutas.value) {
                    return Loading("Cargando historial de rutas...");
                  } else
                    return Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(0.0),
                          child: Column(children: [
                            Expanded(
                              flex: 2,
                              child: getRutas(routeX.misRutas, context),
                            ),
                          ]),
                        ),
                        goToMap(),
                      ],
                    );
                },
              ),
              
            ],
          )),
    );
  }

  Widget goToMap() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 20.0),
        child: GestureDetector(
          onTap: () {
            Get.to(() => MyMap());
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
    );
  }

  Widget getRutas(List<RouteEntity> rutas, BuildContext context) {
    if (rutas.isNotEmpty) {
      List<Widget> list = [];
      rutas.sort((a, b) => b.createdAt
          .compareTo(a.createdAt)); //la rura mas reciente se muestra primero
      rutas.forEach((ruta) {
        list.add(RouteCard(mapC, ruta));
      });
      return new ListView(
        padding: EdgeInsets.only(top: 0.0),
        children: list,
      );
    } else {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.20),
          child: Text(
            "Aún no ha agregado ninguna ruta",
            style: TextStyle(color: Colors.blue[800], fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }
}
