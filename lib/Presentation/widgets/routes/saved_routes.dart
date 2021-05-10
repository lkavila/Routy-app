import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/Presentation/GetX/dark_mode_controller.dart';
import 'package:routy_app_v102/Presentation/GetX/route_controller.dart';
import 'package:routy_app_v102/Presentation/widgets/loading_widget.dart';
import 'package:routy_app_v102/Presentation/widgets/routes/list_routes.dart';

class SavedRoutes extends StatefulWidget {
  SavedRoutes({Key key}) : super(key: key);

  @override
  _SavedRoutesState createState() => _SavedRoutesState();
}

class _SavedRoutesState extends State<SavedRoutes> with AutomaticKeepAliveClientMixin{
  
  @override
  Widget build(BuildContext context) {
    final RouteController routeX = Get.find();
    return Container(
       child: GetBuilder<RouteController>(
                builder: (_) {
                  if (routeX.cargandoRutas.value) {
                    return Loading("Cargando rutas guardadas...");
                  } else{
                    print(routeX.misRutas.length);
                    return Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(0.0),
                          child: Column(children: [
                            
                        GetBuilder<DarkModeController>(
                          builder: (_) {
                            return Expanded(
                              flex: 2,
                              child: GetRouteList(
                                  routeX.misRutasDto
                                      .where((element) =>
                                          element.frecuente == true)
                                      .toList(),
                                      'DeleteAllRoutes1', 'GoToMap1'
                                  ),
                            );
                          }),
                          ]),
                        ),

                      ],
                    );
                  }
                },
              ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}