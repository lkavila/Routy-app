import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/Domain/entities/routeDTO.dart';
import 'package:routy_app_v102/Presentation/GetX/dark_mode_controller.dart';
import 'package:routy_app_v102/Presentation/GetX/map_controller.dart';
import 'package:routy_app_v102/Presentation/GetX/route_controller.dart';
import 'package:routy_app_v102/Presentation/GetX/user_controller.dart';
import 'package:routy_app_v102/Presentation/widgets/routes/go_to_map.dart';
import 'package:routy_app_v102/Presentation/widgets/routes/mode_dark_switcher.dart';
import 'package:routy_app_v102/Presentation/widgets/routes/route_card.dart';

class GetRouteList extends StatelessWidget {
  final List<RouteDTO> rutas;
  final String tag;
  final String tagMap;
  const GetRouteList(this.rutas, this.tag, this.tagMap, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: getRutas(rutas, context),
    );
  }

  //boton eliminar todas las rutas
  Widget deleteAllroutes(BuildContext context) {
    final UserController _userController = Get.find();
    final RouteController _routeController = Get.find();
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            title: Icon(
              Icons.room_outlined,
              color: Colors.orange[900],
              size: 100,
            ),
            content: Text(
              "¿Está seguro de querer eliminar todos las rutas? Luego no podrá recuperarlas.",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    _routeController.deleteAllRoutes(_userController.user.id);
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
      child: Icon(
        Icons.delete_forever,
        color: Colors.indigo[900],
        size: 40,
      ),
      backgroundColor: Colors.red,
      heroTag: tag,
      mini: true,
    );
  }

  Widget headerOptions(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [deleteAllroutes(context), GradientsSwitcher(), GoToMap(tagMap)]);
  }

  Widget getRutas(List<RouteDTO> rutas, BuildContext context) {
    final DarkModeController darkModeController = Get.find();
    final MapController mapController = Get.find();
    if (rutas.isNotEmpty) {
      List<Widget> list = [];
      print(rutas.first.origen);

      list.add(headerOptions(context));

      rutas.sort((a, b) => b.createdAt
          .compareTo(a.createdAt)); //la rura mas reciente se muestra primero
      rutas.forEach((ruta) {
        list.add(RouteCard(mapController, ruta));
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
            style:
                TextStyle(color: darkModeController.colorMode(), fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }
}
