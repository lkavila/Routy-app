import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:routy_app_v102/Presentation/GetX/user.dart';
import 'package:routy_app_v102/Presentation/widgets/dialog_marker.dart';
import 'package:routy_app_v102/models/route.dart';
import 'package:routy_app_v102/Data/datasources/hereGeocode.dart';
import 'package:routy_app_v102/Data/datasources/networking.dart';
import 'package:routy_app_v102/Presentation/widgets/hidden_drawer_menu.dart';
import 'package:routy_app_v102/Presentation/widgets/menu_widget.dart';
import 'package:routy_app_v102/Presentation/widgets/ruta_widget.dart';
import 'package:routy_app_v102/utils.dart';
import 'package:uuid/uuid.dart';

class MyMap extends StatefulWidget {
  final MyRoute ruta;
  final int tipoMenu;
  const MyMap(this.ruta,this.tipoMenu, {Key key}): super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyMap> {
  final UserX userx = Get.find();
  GoogleMapController mapController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<LatLng> polyPoints = []; // For holding Co-ordinates as LatLng
  List<LatLng> puntos = []; 
  final Set<Polyline> polyLines = {}; // For holding instance of Polyline
  final Set<Marker> markers = {}; // For holding instance of Marker
  var data;
  var uuid = Uuid();
  MyRoute miRuta;
  double onTapLat, onTapLng, distancia, duracion;
  BitmapDescriptor start;
  BitmapDescriptor finish;
  bool dialog = false;
  Marker marker;
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
      data = await openRoute.getPolylines(puntos);
      if(data!="YAPER"){
        // We can reach to our desired JSON data manually as following
        LineString ls =
            LineString(data['features'][0]['geometry']['coordinates']);
        print("antes de polylines");
        for (int i = 0; i < ls.lineString.length; i++) {
          polyPoints.add(LatLng(ls.lineString[i][1], ls.lineString[i][0]));
        }

        if (polyPoints.length == ls.lineString.length) {
          print("antes de polylines");
          setPolyLines();
          print("despues de polylines");
        }
        
        distancia = data['features'][0]['properties']['summary']["distance"];
        duracion = data['features'][0]['properties']['summary']["duration"];
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
        markerPoints: puntos,
        polyPoints: polyPoints,
        tipoCar: "driving-car"
      );
      });

    }
  }


  
  setPolyLines() {
    Polyline polyline = Polyline(
      polylineId: PolylineId("polyline"),
      color: Colors.blue[800],
      points: polyPoints,
      width: 3,
    );
    polyLines.add(polyline);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(130, 130)),
        'assets/images/map.png')
        .then((onValue) {
      finish = onValue;
    });

    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(130, 130)),
        'assets/images/location.png')
        .then((onValue) {
      start = onValue;
    });

    if (widget.ruta!=null){
      miRuta = widget.ruta;
      polyPoints = widget.ruta.polyPoints;
      setPolyLines();
      widget.ruta.markerPoints.forEach((element) {
        createMarkers(element.latitude, element.longitude);
      });
    
    
    }
    //getJsonData();
  }

    createMarkers(double lat, double lng) {
      puntos.add(LatLng(lat, lng));
      if (markers.isEmpty){
      markers.add(
        Marker(
          markerId: MarkerId("1"),
          position: LatLng(lat, lng),
          icon: start,
          infoWindow: InfoWindow(
            title: "Home",
          ),
          onTap: (){
              /*showDialog(
                context: context,
                builder: (context) => AlertDialog(
              title: Text("Modificar marker"),
              content: Container(
                height: 150,
                child: Column(

                  children: [
                    TextButton(onPressed: (){
                      Utils.hacerInicio(markers, marker);
                      },
                      child: Text("Hacer inicio")),

                    TextButton(onPressed: (){
                      Utils.hacerInicio(markers, marker);
                      },
                      child: Text("Hacer inicio")),

                    TextButton(onPressed: (){
                      Utils.hacerInicio(markers, marker);
                      },
                      child: Text("Hacer inicio")),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: (){

                  Navigator.of(context, rootNavigator: true).pop();

                }, child: Text("Cancelar"))
              ],
            ),
            ).then((value) => null); */
            setState(() {
              //marker = markers.where((element) => element.position==LatLng(lat, lng)).single;
              markers.removeWhere((element) => element.markerId==MarkerId(lat.toString()));
              puntos.removeWhere((element) => (element == LatLng(lat, lng)));            
            });
          }
        ),
      );       
      }else markers.add(
        Marker(
          markerId: MarkerId(lat.toString()),
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(
            title: "Home",
            snippet: "lat: "+lat.toString(),
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
                  print("despues de llamado");
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
              return Ruta(miRuta, widget.tipoMenu);
            }else{return SizedBox();}
          }),

          Builder(builder: (context){
            if(dialog){
              return DialogMarker(marker, markers);
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