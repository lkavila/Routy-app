import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:routy_app_v102/models/route.dart';

class Ruta extends StatelessWidget {
  final MyRoute ruta;
  const Ruta(this.ruta, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> depar;
    print(ruta.departamentos);

    return Container(
      child: 
      Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: EdgeInsets.fromLTRB(4, 0, 0, 0),

            child: Container(
            width: MediaQuery.of(context).size.width*0.97,
            height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Color.fromRGBO(131,230,251,0.85),
              ),
              
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Builder(builder: (context){
                    
                    if(ruta.departamentos.contains(" ")){
                      depar = ruta.departamentos.split(" ");
      
                      
                      return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 10,),
                            FaIcon(FontAwesomeIcons.mapMarkedAlt, color: Colors.orange[900], size: 18,),
                            SizedBox(width: 5,),
                            Text('Departamentos:', style:style(),),
                            SizedBox(width: 5,),
                            Text('${depar.first}',style:style2()),
                            SizedBox(width: 5,),
                            FaIcon(FontAwesomeIcons.arrowRight, color: Colors.indigo[900], size: 13,),
                            SizedBox(width: 5,),
                            Text('${depar.last}',style:style2()),
                          ],
                        );
                    }else{
                       return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 10,),
                          FaIcon(FontAwesomeIcons.mapMarkedAlt, color: Colors.orange[900], size: 18,),
                          SizedBox(width: 10,),
                          Text('Departamento:', style:style(),),
                          SizedBox(width: 5,),
                          Text('${ruta.departamentos}',style:style2()),
                        ],
                      );
                    }
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10,),
                      FaIcon(FontAwesomeIcons.mapMarkerAlt, color: Colors.orange[900], size: 18,),
                      SizedBox(width: 10,),
                      Text('Origen:', style:style(),),
                      SizedBox(width: 5,),
                      Text('${ruta.origen}',style:style2()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10,),
                      FaIcon(FontAwesomeIcons.mapMarkerAlt, color: Colors.orange[900], size: 18,),
                      SizedBox(width: 10,),
                      Text('Destino:', style:style(),),
                      SizedBox(width: 5,),
                      Text('${ruta.destino}',style:style2()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10,),
                      FaIcon(FontAwesomeIcons.route, color: Colors.orange[900], size: 18,),
                      SizedBox(width: 10,),
                      Text('Distancia:', style:style(),),
                      SizedBox(width: 5,),
                      Text('${ruta.distancia}', style:style2()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10,),
                      FaIcon(FontAwesomeIcons.clock, color: Colors.orange[900], size: 18,),
                      SizedBox(width: 10,),
                      Text('Tiempo en carro:', style:style(),),
                      SizedBox(width: 5,),
                      Text('${ruta.duracion}', style:style2() ),
                    ],
                  ),
                  Container(
                    width: 180,
                    child: ElevatedButton(
                        onPressed: (){

                        },
                        //style: ButtonStyle(minimumSize: MaterialStateProperty.resolveWith((state) => Size(100, 40))), 
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Elegir vehículo", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                            FaIcon(FontAwesomeIcons.handPointUp, color: Colors.white),
                          ]
                        )
                    )
                  )
                ],
                )
              
          ),
          ),
        ),
    );
  }
  TextStyle style(){
      return TextStyle(color: Color.fromRGBO(12,55,106,1), fontSize: 14, fontWeight: FontWeight.w800);
  }

  TextStyle style2(){
      return TextStyle(color: Color.fromRGBO(12,55,106,1), fontSize: 14, fontWeight: FontWeight.normal);
  }
}