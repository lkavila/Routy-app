import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../secrets.dart';


class OpenRouteS{
  
  Future getRoute(List<LatLng> lugares, String circular) async{

    List<List<double>> coordenadas = convertir(lugares); //quitar esta coversion,poner con tipo de dato dynamic 
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8",
      "x-api-key": Secrets.orsAPIKEY,
      "circular": circular,
      };

      http.Response response = await http.post(Uri.https("tsp-routy.herokuapp.com", "calcularRuta"),
                          headers: headers,
                          body: jsonEncode(<String, dynamic>{
                                "locations": coordenadas,
                                "metrics": ["distance"],
                                "units": "m"
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
        return 400;
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
