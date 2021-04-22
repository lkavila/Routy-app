import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/Controllers/convertir_tiempo_distancia.dart';
import 'package:routy_app_v102/Domain/entities/route.dart';
import 'package:routy_app_v102/Presentation/GetX/map_controller.dart';
import 'package:routy_app_v102/Presentation/GetX/vehiculo_elegido.dart';
import 'package:routy_app_v102/Presentation/pages/home/elegir_vehiculo.dart';

class Ruta extends StatelessWidget {
  const Ruta( {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MapController mc = Get.find();
    List<String> depar;
    Elegido elegido = Get.find();
    print(mc.ruta.departamentos);

    return Container(
      child: 
      Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: EdgeInsets.all( MediaQuery.of(context).size.width*0.01,),

            child: Container(
            width: MediaQuery.of(context).size.width*0.98,
            height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: Color.fromRGBO(131,230,251,0.9),
              ),
              
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(width: 30,),
                  Builder(builder: (context){
                    
                    if(mc.ruta.departamentos.contains(" ")){
                      depar = mc.ruta.departamentos.split(" ");
      
                      return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 20,),
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
                          Text('${mc.ruta.departamentos}',style:style2()),
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
                      Flexible(
                        child:Text('${mc.ruta.origen}',style:style2(), overflow: TextOverflow.clip,),
                      ),
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
                      Flexible(child: 
                      Text('${mc.ruta.destino}',style:style2(), overflow: TextOverflow.fade,),
                      ),
                      
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
                      Flexible(child: 
                        Text(
                          '${ConvertirTD.convertDistancia(mc.ruta.distancia)}',
                          style:style2(),
                          overflow: TextOverflow.fade,),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10,),
                      FaIcon(FontAwesomeIcons.clock, color: Colors.orange[900], size: 18,),
                      SizedBox(width: 10,),
                      texto(mc.tipoMenu, elegido.elegido),
                      SizedBox(width: 5,),
                      Text('${ConvertirTD.convertirTiempo(mc.ruta.duracion)}', style:style2() ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                      boton(mc.tipoMenu, mc.ruta),
                      GetBuilder<MapController>(builder: (_){
                          if(mc.ruta.frecuente){
                            return IconButton(icon: Icon(
                              Icons.save, 
                              color: Colors.lightBlueAccent,
                              size: 40,), onPressed: (){
                                mc.makeFrecuent();
                                });
                          }else{
                            return IconButton(icon: Icon(
                              Icons.save, 
                              color: Colors.grey,
                              size: 40,), onPressed: (){
                                mc.makeFrecuent();
                                
                                });

                          } 
                      })

                    ],
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

  Text texto(int tipoMenu, String elegido){
    if (tipoMenu==0 || tipoMenu==4){
        return Text('Tiempo en carro:', style:style(),);
    }else {
      return Text('Tiempo en $elegido:', style:style(),);
    }
  }

 ElevatedButton boton(int tipoMenu, RouteEntity ruta){
   switch (tipoMenu) {
     case 0:
            return  ElevatedButton(
                        onPressed: (){
                          Get.to( () => ElegirVehiculo(ruta, tipoMenu));
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith((states) => Color.fromRGBO(255, 255, 255, 0.7))
                        ),
                        //style: ButtonStyle(minimumSize: MaterialStateProperty.resolveWith((state) => Size(100, 40))), 
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Elegir vehículo", style: TextStyle(color: Colors.blue[900], fontSize: 16, fontWeight: FontWeight.bold)),
                            FaIcon(FontAwesomeIcons.handPointUp, color: Colors.blue[900]),
                          ]
                        )
                    );
       break;
     case 1:
            return  ElevatedButton(
                        onPressed: (){
                          Get.to( () => ElegirVehiculo(ruta, tipoMenu));
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith((states) => Color.fromRGBO(255, 255, 255, 0.7))
                        ),
                        //style: ButtonStyle(minimumSize: MaterialStateProperty.resolveWith((state) => Size(100, 40))), 
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("En camino", style: TextStyle(color: Colors.blue[900], fontSize: 16, fontWeight: FontWeight.bold)),
                            FaIcon(FontAwesomeIcons.handPointUp, color: Colors.blue[900]),
                          ]
                        )
                    );
       break;
     case 2:
            return  ElevatedButton(
                        onPressed: (){
                          Get.to( () => ElegirVehiculo(ruta, tipoMenu));
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith((states) => Color.fromRGBO(255, 255, 255, 0.7))
                        ),
                        //style: ButtonStyle(minimumSize: MaterialStateProperty.resolveWith((state) => Size(100, 40))), 
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Finalizar", style: TextStyle(color: Colors.blue[900], fontSize: 16, fontWeight: FontWeight.bold)),
                            FaIcon(FontAwesomeIcons.handPointUp, color: Colors.blue[900]),
                          ]
                        )
                    );
       break;

     default:
            return  ElevatedButton(
                        onPressed: (){
                          Get.to( () => ElegirVehiculo(ruta, tipoMenu));
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith((states) => Color.fromRGBO(255, 255, 255, 0.7))
                        ),
                        //style: ButtonStyle(minimumSize: MaterialStateProperty.resolveWith((state) => Size(100, 40))), 
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Elegir vehículo", style: TextStyle(color: Colors.blue[900], fontSize: 16, fontWeight: FontWeight.bold)),
                            FaIcon(FontAwesomeIcons.handPointUp, color: Colors.blue[900]),
                          ]
                        )
                    );
 
   }
 }
}