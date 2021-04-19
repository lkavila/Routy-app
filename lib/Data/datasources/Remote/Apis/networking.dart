import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../secrets.dart';
import 'package:routy_app_v102/Data/datasources/Remote/Apis/tsp.dart';


class OpenRoute{
  
  Future getPolylines(List<LatLng> lugares, String circular) async{

    OpenRouteS _orsTsp = OpenRouteS();
    
    dynamic data = await _orsTsp.getRoute(lugares, circular);

    if (data!=400){
      print("Esta es la distancia minima: "+data['distanciaMinima'].toString());
      List<dynamic> coordenadas = data['caminoMinimo'];
      print("el orden del camino más corto es ${data["orden"]}");
      Map<String, String> headers = {
        "Authorization": Secrets.orsAPIKEY,
        "Content-Type": "application/json; charset=UTF-8",
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
          return null;
        }

      }else{

        return null;
      }
  }

}
