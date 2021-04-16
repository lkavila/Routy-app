import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:routy_app_v102/Presentation/widgets/dialog_marker.dart';

class Utils {


  static Set<Marker> hacerInicio(Set<Marker> markers, Marker marker){

      BitmapDescriptor start;
      BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(130, 130)),
        'assets/images/location.png')
        .then((onValue) {
      start = onValue;
    });

      Marker marker2; //este marker remplazará al inicio
      Marker marker3; //este marker será el que se va a eliminar 
      markers.forEach((element) {
        if(element.markerId==MarkerId("1")){
          marker3 = element;
        }
      });

      print(marker2.position);
      markers.remove(marker3);
      markers.add(marker2);

      LatLng pos = marker.position;
      //Este será el nuevo inicio
      Marker marker4 = Marker(
        markerId: MarkerId("1"),
          position: pos,
          infoWindow: InfoWindow(
            title: "Home",
          ),
          icon: start,
          onTap: (){

          }        
        ); 
      markers.remove(marker);
      markers.add(marker4);

        marker2 =  Marker(
          markerId: MarkerId(marker3.position.latitude.toString()),
          position: marker3.position,
          infoWindow: InfoWindow(
            title: "Home",
          ),
          onTap: (){
              DialogMarker(marker2, markers);
          }
            );
            
  return markers;

  }
} 