import 'package:flutter/material.dart';
import 'package:routy_app_v102/widgets/hidden_drawer_menu.dart';
import 'package:routy_app_v102/widgets/menu_widget.dart';

class MisRutas extends StatelessWidget {
  MisRutas({Key key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final List<String> rutas = ["Ruta 1", "Carrera 10C #58-5", "Distancia: 26 km", "Duración: 21 min", "Ruta 2", "Carrera 33 sur #46", "Distancia: 13 km", "Duración: 18 min", "Ruta 3", "Calle 59G1 #3B-33", "Distancia: 56 km", "Duración: 68 min","Ruta 1", "Carrera 10C #58-5", "Distancia: 26 km", "Duración: 21 min"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerMenu(),
      body: Stack(
        children: [
          Container(
          padding: EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              Text("Mis Rutas", style: TextStyle(fontFamily: 'pacifico', fontSize: 25, color:  Colors.blue[700],),),

            ],
            ),
            Expanded(
              child:  getRutas(rutas, context),
                
              ),
            
            

            ]
          ),
          ),

            Menu(_scaffoldKey), //este es el menu que abre el drawer


        ],
      ),
    );
  }


  Widget getRutas(List<String> rutas, BuildContext context)
  {
    List<Widget> list = [];
    for(var i = 0; i < rutas.length; i=i+4){
        list.add(carWidget(rutas[i], rutas[i+1], rutas[i+2], rutas[i+3], context));
    }
    return new ListView(children: list);
  }

  Widget carWidget(String titulo, String direccion, String distancia, String duracion, BuildContext context){
    final List<Color> _colors = [Colors.blue, Colors.cyan[400]];
    final List<double> _stops = [0.4, 1];
    return Container(
            width: 400,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              ),
            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            
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
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: _colors,
                stops: _stops,
                  ),
                ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                      title: Text("$titulo", style: TextStyle(color: Colors.white,fontSize: 20, fontWeight: FontWeight.w600),),
                      subtitle: Text('$direccion',
                            style: TextStyle(color: Colors.white, fontSize: 14,),
                          ),
                        ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                      child: Text('$distancia',
                            style: TextStyle(color: Colors.white, fontSize: 14,),
                          ),
                    ),
                    
                    Padding(
                      padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                      child: Text('$duracion',
                            style: TextStyle(color: Colors.white, fontSize: 14,),
                          ),
                    ),
                    ],
                  ),
        )

      )
    );
  }

  
}