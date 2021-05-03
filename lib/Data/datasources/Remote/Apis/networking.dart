import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../secrets.dart';


class OpenRoute{
  
  Future getPolylines(List<dynamic> lugares, String circular) async{


      Map<String, String> headers = {
        "Authorization": Secrets.orsAPIKEY,
        "Content-Type": "application/json; charset=UTF-8",
        };

        http.Response response = await http.post(
          Uri.https("api.openrouteservice.org", "v2/directions/driving-car/geojson"),
                            headers: headers,
                            body: jsonEncode(<String, List<dynamic>>{
                              "coordinates": lugares
                                  })
                    );
        print(lugares);
        if(response.statusCode == 200) {
          String data = response.body;
          return jsonDecode(data);

        }
        else{
          
          print(response.statusCode);
          print(response.toString());
          return null;
        }

  }

}