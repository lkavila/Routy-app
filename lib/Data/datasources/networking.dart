import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:routy_app_v102/secrets.dart';
import 'package:routy_app_v102/Data/datasources/tsp.dart';


class OpenRoute{
  
  Future getPolylines(List<LatLng> lugares) async{

    OpenRouteS orsTsp = OpenRouteS();
    
    dynamic data = await orsTsp.getRoute(lugares);

    if (data!=400){
        
      List<dynamic> coordenadas = data['caminoMinimo'];
      print("el orden es ${data["orden"]}");
      Map<String, String> headers = {
        "Authorization": Secrets.orsAPIKEY,
        "Content-Type": "application/json; charset=UTF-8",
        "Accept-Encoding": "gzip, deflate, br",
        "connection": "keep-alive",
        };

        http.Response response = await http.post(
          Uri.https("api.openrouteservice.org", "v2/directions/driving-car/geojson"),
                            headers: headers,
                            body: jsonEncode(<String, List<dynamic>>{
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

      }else{

        return "YAPER";
      }
  }

}
