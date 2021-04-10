import 'package:http/http.dart' as http;
import 'dart:convert';
//Este codigo no se esta usando, aunque si funciona
//Esta API no es muy precisa con las direcciones
class GeoCodeReverse {

  final double lon;
  final double lat;

  GeoCodeReverse({this.lon, this.lat});


  Future fetchGeo() async{
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8",
      };
      print(lon.toString()+ "longitud");
      print(lat.toString()+ "latitud");
    Map<String, String> parametros = {
      "api_key": "",
      "point.lat": lon.toString(),
      "point.lon": lat.toString(),
      "size": "1",
      "boundary.country": "COL",
      };
      var url = Uri.https('api.openrouteservice.org', '/geocode/reverse?', parametros);
    http.Response response = await http.get(url,headers: headers);
    //http.Response response = await http.get(Uri.https(url,"geocode/reverse?",parametros), headers: headers);
    if(response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);

    }
    else{
      print(response.body);
      print(response.statusCode);
      return null;
    }
  }

}