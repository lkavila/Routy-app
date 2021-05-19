import 'dart:async';
import 'package:background_location/background_location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:routy_app_v102/Domain/entities/my_location.dart';

class DeviceLocation {
 BackgroundLocation location = new BackgroundLocation();
 double distancia;
 double tiempo;
 List<double> veloPromedio;
 List<double> datos;
 double velocidadProm;

  DeviceLocation(){
  veloPromedio = [];
  velocidadProm = 0;
  distancia = 0;
  tiempo = 0;
  }



 Future<LatLng> getMyCurrentLocation() async{
  Location value = await location.getCurrentLocation();
  return LatLng(value.latitude, value.longitude);
  }

  stopUpdates(){
    BackgroundLocation.stopLocationService();
  }

  MyLocation startUpdates(MyLocation location){
    BackgroundLocation.getPermissions(
      onGranted: () {
        print("Permisos otorgados");
        BackgroundLocation.startLocationService();
        BackgroundLocation.setAndroidNotification(
          title: "Ha empezado su ruta",
                message: "Se van a ir guardando los datos de su recorrido aún en segundo plano",
                icon: "@mipmap/ic_launcher",
        );
        BackgroundLocation.getLocationUpdates((value){
            
            //tiempo = tiempo + 0.5;
            location.tiempo = value.time;
            if(value.speed>1){
              location.velocidad = value.speed;
              veloPromedio.add(value.speed);//la velocidad promedio solo se actualiza si la velocidad actual es mayor a 1m/s
              location.velocidadPromedio = veloPromedio.reduce((value, element) => value+element)/veloPromedio.length;
              location.distancia = location.distancia + value.speed;
              location.latitud = value.latitude;
              location.longitud = value.longitude;
              print(location.distancia);
            }   
            return location; 
        });

        

      },
      onDenied: () {
        // Show a message asking the user to reconsider or do something else

        return null;
      },
    );
    return null;
  }
}
