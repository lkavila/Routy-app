
import 'package:flutter/material.dart';
import 'package:routy_app_v102/provider/sign_in.dart';
import 'package:routy_app_v102/screens/home/logged_in.dart';
import 'package:routy_app_v102/screens/map.dart';
import 'package:routy_app_v102/widgets/hidden_drawer_menu.dart';

class MisRutas extends StatelessWidget {
  final SignInProvider provider;
  MisRutas(this.provider, {Key key}) : super(key: key);

  final List<String> rutas = ["Ruta 1", "Carrera 10C #58-5", "Distancia: 26 km", "Duración: 21 min", "Ruta 2", "Carrera 33 sur #46", "Distancia: 13 km", "Duración: 18 min", "Ruta 3", "Calle 59G1 #3B-33", "Distancia: 56 km", "Duración: 68 min"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(provider),
      body: Container(
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
              Navigator.push(context,MaterialPageRoute(
                maintainState: true,
                builder: (context) => LoggedIn(provider)),);
              
            },
            child: Text('Perfil'),
          ),
        ],
        ),
        getRutas(rutas)
        

        ]
      ),
      ),
    );
  }


  Widget getRutas(List<String> rutas)
  {
    List<Widget> list = [];
    for(var i = 0; i < rutas.length; i=i+4){
        list.add(carWidget(rutas[i], rutas[i+1], rutas[i+2], rutas[i+3]));
    }
    return new Column(children: list);
  }

  Widget carWidget(String titulo, String direccion, String distancia, String duracion){
    final List<Color> _colors = [Colors.blue, Colors.cyan, Colors.cyanAccent];
    final List<double> _stops = [0.33, 0.66, 1];
    return Container(
            width: 300,
            height: 150,
            padding: EdgeInsets.fromLTRB(5.0, 20.0, 5.0, 0.0),
      child: Card(
        elevation: 10.0,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                      title: Text("$titulo", style: TextStyle(color: Colors.white,fontSize: 20, fontWeight: FontWeight.w600),),
                      subtitle: Text('$direccion',
                            style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                      child: Text('$distancia',
                            style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                    ),
                    
                    Padding(
                      padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                      child: Text('$duracion',
                            style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                    ),
                    ],
                  ),
        )

      )
    );
  }

  
}