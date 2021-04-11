import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/Controllers/convertir_tiempo_distancia.dart';
import 'package:routy_app_v102/GetX/route.dart';
import 'package:routy_app_v102/GetX/user.dart';
import 'package:routy_app_v102/models/route.dart';
import 'package:routy_app_v102/screens/map.dart';
import 'package:routy_app_v102/widgets/background_painter.dart';
import 'package:routy_app_v102/widgets/hidden_drawer_menu.dart';
import 'package:routy_app_v102/widgets/menu_widget.dart';

class MisRutas extends StatelessWidget {
  MisRutas({Key key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final RouteX routeX = Get.find();
  
  @override
  Widget build(BuildContext context) {
    routeX.misRutas.forEach((element){
      print(element.origen);
      }); 
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerMenu(),
      body: GetBuilder<RouteX>(
        builder: (_){
          if (routeX.misRutas.isEmpty){
            return   buildLoading();
          }else return Stack(
              children: [
                Container(
                padding: EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                    Text("Mis Rutas", style: TextStyle(fontFamily: 'pacifico', fontSize: 25, color:  Colors.blue[800],),),
                  ],
                  ),
                  Expanded(
                    flex: 2,
                    child:  getRutas(routeX.misRutas, context),
                    ),
                  ]
                ),
                ),
                  Menu(_scaffoldKey), //este es el menu que abre el drawer
              ],
              );
        },
      ) 
    );
  }
Widget buildLoading() => Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(painter: BackgroundPainter()),
          Center(child: CircularProgressIndicator()),
        ],
      );

  Widget getRutas(List<MyRoute> rutas, BuildContext context)
  {
    List<Widget> list = [];
    rutas.forEach((ruta) {
      list.add(carWidget(ruta.departamentos, ruta.origen, ruta.destino, ConvertirTD.convertDistancia(ruta.distancia), ConvertirTD.convertirTiempo(ruta.duracion), context));
    });
    return new ListView(
      padding: EdgeInsets.only(top: 0.0),
      children: list,
      );
  }

  Widget carWidget(String departamento, String origen, String destino, String distancia, String duracion, BuildContext context){
    final List<Color> _colors = [Colors.indigo[900], Colors.blue[800], Colors.cyanAccent[400]];
    final List<double> _stops = [0.0, 0.4, 1];
    return Container(
            width: 350,
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              ),
            padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
            
      child: Card(
        color: Colors.grey,
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        clipBehavior: Clip.antiAlias,
        child:  Container(
              decoration: BoxDecoration(
              
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: _colors,
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
                      padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
                      child: Text("$departamento", style: TextStyle(color: Colors.white,fontSize: 22, fontWeight: FontWeight.w600),),
                        
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(15.0, 10.0, 5.0, 0.0),
                      child:GestureDetector(
                            child: Image.asset('assets/images/eliminar.png',),
                            onTap: () {
                            
                            },
                          ),
                    )

                  ],),

                    Padding(
                      padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                      child: Text('Origen: $origen',
                            style: TextStyle(color: Colors.white, fontSize: 15,),
                          ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                      child: Text('Destino: $destino',
                            style: TextStyle(color: Colors.white, fontSize: 15,),
                          ),
                    ),
                    
                    Padding(
                      padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                      child: Text('Distancia: $distancia',
                            style: TextStyle(color: Colors.white, fontSize: 15,),
                          ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                      child: Text('Duración: $duracion',
                            style: TextStyle(color: Colors.white, fontSize: 15,),
                          ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(205.0, 0.0, 0.0, 0.0),
                      child:TextButton(onPressed: (){
                            Navigator.push(context,MaterialPageRoute(builder: (context) => MyMap(null)),);
                          }, child: Text("Ver en mapa", style: TextStyle(color: Colors.indigo[900], fontSize: 15),))
                    )
                    ],
                  ),
        )

      )
    );
  }

  
}