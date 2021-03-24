
import 'package:flutter/material.dart';
import 'package:routy_app_v102/screens/home/logged_in.dart';
import 'package:routy_app_v102/screens/map.dart';

class MisRutas extends StatelessWidget {
  MisRutas({Key key}) : super(key: key);

  final List<String> rutas = ["Ruta 1", "Carrera 10C #58-5", "Ruta 2", "Carrera 33 sur #46", "Ruta 3", "Calle 59G1 #3B-33"];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(5.0, 50.0, 5.0, 0.0),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => MyMap()),);
              
            },
            child: Text('Ir a Mapa'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => LoggedIn()),);
              
            },
            child: Text('Perfil'),
          ),
        ],
        ),
        getRutas(rutas)
        

        ]
      )
    );
  }


  Widget getRutas(List<String> rutas)
  {
    List<Widget> list = [];
    for(var i = 0; i < rutas.length; i=i+2){
        list.add(carWidget(rutas[i], rutas[i+1]));
    }
    return new Column(children: list);
  }

  Widget carWidget(String titulo, String direccion){
    final List<Color> _colors = [Colors.blue, Colors.cyan, Colors.cyanAccent];
    final List<double> _stops = [0.33, 0.66, 1];
    return Container(
            width: 300,
            height: 130,
            padding: EdgeInsets.fromLTRB(5.0, 20.0, 5.0, 0.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Container(
              decoration: BoxDecoration(
              gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: _colors,
              stops: _stops,
                ),
          ),
        child: Column(
          children: [
            ListTile(
                title: Text("$titulo", style: TextStyle(color: Colors.white,fontSize: 20, fontWeight: FontWeight.w600),),
                subtitle: Text('$direccion',
                      style: TextStyle(color: Colors.white.withOpacity(0.75), fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  ),
              ],
            ),
        )

      )
    );
  }

  
}