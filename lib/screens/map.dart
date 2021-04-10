import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:routy_app_v102/Controllers/convertir_tiempo_distancia.dart';
import 'package:routy_app_v102/GetX/user.dart';
import 'package:routy_app_v102/models/route.dart';
import 'package:routy_app_v102/service/hereGeocode.dart';
import 'package:routy_app_v102/service/networking.dart';
import 'package:routy_app_v102/widgets/hidden_drawer_menu.dart';
import 'package:routy_app_v102/widgets/menu_widget.dart';
import 'package:routy_app_v102/widgets/ruta_widget.dart';
import 'package:uuid/uuid.dart';

class MyMap extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyMap> {
  final UserX userx = Get.find();
  GoogleMapController mapController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final List<LatLng> polyPoints = []; // For holding Co-ordinates as LatLng
  final List<LatLng> puntos = []; 
  final Set<Polyline> polyLines = {}; // For holding instance of Polyline
  final Set<Marker> markers = {}; // For holding instance of Marker
  var data;
  var uuid = Uuid();
  MyRoute miRuta;
  double onTapLat;
  double onTapLng;
  String distancia="";
  String duracion="";
  // Dummy Start and Destination Points

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    
  }


  void getJsonData() async {
    // Create an instance of Class NetworkHelper which uses http package
    // for requesting data to the server and receiving response as JSON format

    OpenRoute openRoute = new OpenRoute(); 


    try {
      // getData() returns a json Decoded data
      data = await openRoute.getRoute(puntos);
      if(data!="YAPER"){
        // We can reach to our desired JSON data manually as following
        LineString ls =
            LineString(data['features'][0]['geometry']['coordinates']);

        for (int i = 0; i < ls.lineString.length; i++) {
          polyPoints.add(LatLng(ls.lineString[i][1], ls.lineString[i][0]));
        }

        if (polyPoints.length == ls.lineString.length) {
          setPolyLines();
        }
        
        distancia = ConvertirTD.convertDistancia(data['features'][0]['properties']['summary']["distance"]);
        duracion = ConvertirTD.convertirTiempo(data['features'][0]['properties']['summary']["duration"]);
      }
    } catch (e) {
      print(e);
    }

    List<String> dirOrigen = await GeoCodeReverse.fetchGeo(puntos.first.longitude, puntos.first.latitude);
    List<String> dirDestino = await GeoCodeReverse.fetchGeo(puntos.last.longitude, puntos.last.latitude);

    print(dirDestino);
    print(dirOrigen);
    if(dirDestino!=null && dirOrigen!=null){
      String departamentoO = dirOrigen.last;
      String departamentoD = dirDestino.last;
      String departamentos;
      if(departamentoO!=departamentoD){
        departamentos = departamentoO+" "+departamentoD;
      }else{
        departamentos = departamentoD;
      }

      setState(() {
        miRuta = new MyRoute(
        id: uuid.v1(), 
        userId: userx.myUser.id,
        createdAt: Timestamp.now(),
        origen: dirOrigen.first,
        destino: dirDestino.first,
        circular: false,
        distancia: distancia,
        duracion: duracion,
        departamentos: departamentos,
        polyLines: polyLines,
        markers: markers,
        puntos: polyPoints,
        tipoCar: "driving-car"
      );
      });

    }
  }


  
  setPolyLines() {
    Polyline polyline = Polyline(
      polylineId: PolylineId("polyline"),
      color: Colors.indigo,
      points: polyPoints,
      width: 4,
    );
    polyLines.add(polyline);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    //getJsonData();
  }

    createMarkers(double lat, double lng) {
      puntos.add(LatLng(lat, lng));
      markers.add(
        Marker(
          markerId: MarkerId(lat.toString()),
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(
            title: "Home",
            snippet: "lat: "+lat.toString()+"| long: "+lng.toString(),
          ),
          onTap: (){
            setState(() {
              markers.removeWhere((element) => element.markerId==MarkerId(lat.toString()));
              puntos.removeWhere((element) => (element == LatLng(lat, lng)));            
            });

          }
        ),
      );
      setState(() {
        
      });
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerMenu(),
      body:  Stack(
          children: [
          GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: const LatLng(10.90352, -74.79463),
            zoom: 15,
          ),
          onTap: (data) {
            print(data);
            createMarkers(data.latitude, data.longitude);
            if(polyLines.isNotEmpty){
              setState(() {
                polyLines.clear();
                polyPoints.clear();
                miRuta = null;
                distancia = "";
                duracion = "";
              }); 
            }
            },
          markers: markers,
          polylines: polyLines,
        ),


        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 40, 10, 0),

            child: Container(
            width: 95,
            height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color.fromRGBO(131,230,251,0.5),
              ),
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    polyLines.clear();
                    polyPoints.clear();
                    puntos.clear();
                    markers.clear();
                    miRuta = null;
                    distancia = "";
                    duracion = "";                 
                  });

                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FaIcon(FontAwesomeIcons.broom, color: Colors.indigo),
                  Text('Limpiar', style: TextStyle(color: Colors.grey[800], fontSize: 16, fontWeight: FontWeight.bold),),
                ],
              )
              ),
          ),
          ),
        ),

        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 30),

            child: Container(
            width: 160,
            height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color.fromRGBO(131,230,251,0.5),
              ),
              child: GestureDetector(
                onTap: (){

                  getJsonData();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FaIcon(FontAwesomeIcons.route,color: Colors.indigo),
                  Text('Ver ruta óptima', style: TextStyle(color: Colors.grey[800], fontSize: 16, fontWeight: FontWeight.bold),),
                ],
              )
              ),
          ),
          ),
        ),

          Builder(builder: (context){
            
            if(miRuta!=null){
              return Ruta(miRuta);
            }else{return SizedBox();}
          }),
        
          Menu(_scaffoldKey), //este es el menu que abre el drawer
          ]
      ),

    );
  }
}

//Create a new class to hold the Co-ordinates we've received from the response data

class LineString {
  LineString(this.lineString);
  List<dynamic> lineString;
}