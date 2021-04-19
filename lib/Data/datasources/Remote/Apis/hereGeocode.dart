import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../secrets.dart';


class GeoCodeReverse {

  Future<List<String>> fetchGeo(double lon, double lat) async{

    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8",
      };
    Map<String, String> parametros = {
      "apikey": Secrets.hereAPIKEY,
      "at": lat.toString()+","+lon.toString(),
      "lang": "es"
      };
      var url = Uri.https('revgeocode.search.hereapi.com', '/v1/revgeocode', parametros);
    http.Response response = await http.get(url,headers: headers);
    
    if(response.statusCode == 200) {
      var dir = jsonDecode(utf8.decode(response.bodyBytes));
      var pro = dir['items'][0]['address'];
      String street = pro['street'];
      List<String> list;
      if (street.contains(" ")){
        list = street.split(" ");
      } else {
        list = [street];
      }
      if (list.length==3){
        street = list[0]+" "+list[1]+" "+"#"+list[2];
      }
      List<String> direccion = [street+", "+pro["city"]];
      direccion.add(pro["county"]);
      return direccion;
    
  }else{
      print(response.statusCode);
      print(response.body);
      return null;
    }
  }

}