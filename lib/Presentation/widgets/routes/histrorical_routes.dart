import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/Presentation/GetX/dark_mode_controller.dart';
import 'package:routy_app_v102/Presentation/GetX/route_controller.dart';
import 'package:routy_app_v102/Presentation/widgets/loading_widget.dart';
import 'package:routy_app_v102/Presentation/widgets/routes/list_routes.dart';

class HistoricalRoutes extends StatefulWidget {
  HistoricalRoutes({Key key}) : super(key: key);

  @override
  _HistoricalRoutesState createState() => _HistoricalRoutesState();
}

class _HistoricalRoutesState extends State<HistoricalRoutes> with AutomaticKeepAliveClientMixin{
  
  @override
  Widget build(BuildContext context) {
    final RouteController routeX = Get.find();

    return Container(
       child: GetBuilder<RouteController>(
                builder: (_) {
                  if (routeX.cargandoRutas.value) {
                    return Loading("Cargando historial de rutas...");
                  } else
                    return Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(0.0),
                          child: Column(children: [
                            
                            GetBuilder<DarkModeController>(
                          builder: (_) {
                            return Expanded(
                              flex: 2,
                              child: GetRouteList(routeX.misRutasDto, 'DeleteAllRoutes2', 'GoToMap2'),
                            );
                          }),
                          ]),
                        ),

                      ],
                    );
                },
              ),
    );

  }

  @override
  bool get wantKeepAlive => true;



}