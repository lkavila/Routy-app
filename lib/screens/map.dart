import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:routy_app_v102/service/networking.dart';

class MyMap extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyMap> {
  GoogleMapController mapController;

  final List<LatLng> polyPoints = []; // For holding Co-ordinates as LatLng
  final List<LatLng> puntos = []; 
  final Set<Polyline> polyLines = {}; // For holding instance of Polyline
  final Set<Marker> markers = {}; // For holding instance of Marker
  var data;
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
      }
      print(data['features'][0]['properties']['summary']);
      distancia = (data['features'][0]['properties']['summary']["distance"]/1000).toString().substring(0, 6)+ " km";
      duracion = (data['features'][0]['properties']['summary']["duration"]/60).toString().substring(0, 6)+ " min";
      print("la distancia es "+distancia+" y la duracion en vehiculo es "+duracion);
    } catch (e) {
      print(e);
    }
  }
  
  setPolyLines() {
    Polyline polyline = Polyline(
      polylineId: PolylineId("polyline"),
      color: Colors.lightBlue,
      points: polyPoints,
      width: 2,
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
        ),
      );
      setState(() {
        
      });
    }
  @override
  Widget build(BuildContext context) {
    return Stack(
          children: [
          GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: const LatLng(10.90352, -74.79463),
            zoom: 15,
          ),
          onTap: (data) {
            createMarkers(data.latitude, data.longitude);
            },
          markers: markers,
          polylines: polyLines,
        ),
        SafeArea(
            child: Align(
            alignment: Alignment.topCenter,
            child: Row(
          children:[
            ElevatedButton(onPressed: () {
              getJsonData();
             }, 
             child: Text("Dibujar ruta")),

            ElevatedButton(onPressed: () {
              setState(() {
                polyLines.clear();
                markers.clear();
                polyPoints.clear();
                puntos.clear();
                distancia = "";
                duracion = "";
              });
             }, 
             child: Text("Limpiar mapa")),
          ], 
        ),
        ),
        ),
        SafeArea(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                  child: Text("$distancia", style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.w100,
                            ),),
                ),
                Container(
                    decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                  child: Text("$duracion", style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.w100,
                    ),),
                ),
              ],
            ),
          )
          )
          ]

    );
  }
}

//Create a new class to hold the Co-ordinates we've received from the response data

class LineString {
  LineString(this.lineString);
  List<dynamic> lineString;
}