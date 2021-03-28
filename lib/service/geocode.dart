import 'package:http/http.dart' as http;
import 'dart:convert';

class GeoCodeReverse {

  final double lon;
  final double lat;

  GeoCodeReverse({this.lon, this.lat});


  Future fetchGeo() async{
    String url = "api.openrouteservice.org";
    String apiKey = "5b3ce3597851110001cf6248d4141599836d412aa58e4b7569d36ef5";
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8",
      };
    Map<String, String> parametros = {
      "api_key": "5b3ce3597851110001cf6248d4141599836d412aa58e4b7569d36ef5",
      "point.lon": lon.toString(),
      "point.lat": lat.toString(),
      "size": "1",
      "boundary.country": "COL",
      };
    http.Response response = await http.get(Uri.https(url, "geocode/reverse?api_key=$apiKey&point.lon=$lon&point.lat=$lat&size=1&boundary.country=COL"),headers: headers);
    //http.Response response = await http.get(Uri.https(url,"geocode/reverse?",parametros), headers: headers);
    if(response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);

    }
    else{
      print(response.statusCode);
      return null;
    }
  }

}