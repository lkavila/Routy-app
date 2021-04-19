import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:routy_app_v102/Domain/entities/route.dart';
import 'package:routy_app_v102/Presentation/GetX/route.dart';
import 'package:routy_app_v102/Presentation/GetX/user.dart';
import 'package:routy_app_v102/Presentation/widgets/dialog_marker.dart';
import 'package:routy_app_v102/Presentation/widgets/hidden_drawer_menu.dart';
import 'package:routy_app_v102/Presentation/widgets/menu_widget.dart';
import 'package:routy_app_v102/Presentation/widgets/ruta_widget.dart';

class MyMap extends StatefulWidget {
  final RouteEntity ruta;
  final int tipoMenu;
  const MyMap(this.ruta,this.tipoMenu, {Key key}): super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyMap> {
  final UserX userx = Get.find();
  final RouteX routeX = Get.find();
  GoogleMapController mapController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final Set<Polyline> polyLines = {}; // For holding instance of Polyline
  final Set<Marker> markers = {}; // For holding instance of Marker
  BitmapDescriptor start, finish;
  bool dialog = false;
  Marker marker;
  // Dummy Start and Destination Points

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  
  setPolyLines() {
    Polyline polyline = Polyline(
      polylineId: PolylineId("polyline"),
      color: Colors.blue[700],
      points: routeX.polyPoints,
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
      routeX.ruta = widget.ruta;
      routeX.polyPoints = widget.ruta.polyPoints;
      setPolyLines();
      widget.ruta.markerPoints.forEach((element) {
        createMarkers(element.latitude, element.longitude);
      });
    }
  }

    createMarkers(double lat, double lng) {
      routeX.puntos.add(LatLng(lat, lng));
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
              routeX.puntos.removeWhere((element) => (element == LatLng(lat, lng)));            
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
              routeX.puntos.removeWhere((element) => (element == LatLng(lat, lng)));            
            });

          }
        ),
      );
      setState(() {});
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
                routeX.polyPoints.clear();
                routeX.ruta = null;
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
                    routeX.polyPoints.clear();
                    routeX.puntos.clear();
                    markers.clear();
                    routeX.ruta = null;               
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
                  if (routeX.puntos.length>1){
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("¿Ruta circular?"),
                        content: Text("Despues de llegar al final ¿regresará al inicio?"),
                        actions: [
                          TextButton(
                            onPressed: (){
                            Navigator.of(context).pop(true);
                          }, child: Text("Si")
                          ),
                          TextButton(
                            onPressed: (){
                            Navigator.of(context).pop(false);
                          }, child: Text("No")
                          ),
                          TextButton(
                            onPressed: (){
                            Navigator.of(context).pop(null);
                          }, child: Text("Cancelar")
                          )
                        ],
                      ),
                    ).then((value) {
                        if (value!=null){
                          print("La opcion tomada fue: "+value.toString());
                          routeX.createRoute(value.toString());
                          setPolyLines();
                        }else{print("La opcion tomada fue: Cancelar ");}
                       });
                  }else{
                      showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("No hay suficientes puntos"),
                        content: Text("Para poder calcular la mejor ruta debe haber al menos 2 puntos, para crear puntos debe hacer tap sobre el mapa"),
                        actions: [
                          TextButton(
                            onPressed: (){
                            Navigator.of(context).pop();
                          }, child: Text("OK")
                          )
                        ],
                      ),
                    ); 
                  }
                  
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

          GetBuilder<RouteX>(
            builder: (_){
            if(routeX.ruta!=null){
              return Ruta(routeX.ruta, widget.tipoMenu);
            }else{return SizedBox();}
          }
          ),

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
