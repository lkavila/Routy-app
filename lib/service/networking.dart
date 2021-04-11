import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:routy_app_v102/secrets.dart';


class OpenRoute{
  
  Future getRoute(List<LatLng> lugares) async{

    List<List<double>> coordenadas = convertir(lugares);
    Map<String, String> headers = {
      "Authorization": Secrets.orsAPIKEY,
      "Content-Type": "application/json; charset=UTF-8",
      "Accept-Encoding": "gzip, deflate, br",
      "connection": "keep-alive",
      };

      http.Response response = await http.post(
        Uri.https("api.openrouteservice.org", "v2/directions/driving-car/geojson"),
                          headers: headers,
                          body: jsonEncode(<String, List<List<double>>>{
                            "coordinates": coordenadas
                                })
                  );
      print(coordenadas);
      if(response.statusCode == 200) {
        String data = response.body;
        return jsonDecode(data);

      }
      else{
        
        print(response.statusCode);
        print(response.toString());
        return "YAPER";
      }
  }

  List<List<double>> convertir(List<LatLng> lugares){

    
    List<List<double>> allLatLng = [];
    for (LatLng e in lugares) {
      List<double> latlng = [];
      latlng.add(e.longitude);
      latlng.add(e.latitude);
      allLatLng.add(latlng);
      if (lugares.last==e){
        return allLatLng;
      }
    }
    return allLatLng;
  }


}
