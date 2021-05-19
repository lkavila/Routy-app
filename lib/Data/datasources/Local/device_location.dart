import 'dart:async';
import 'package:background_location/background_location.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:routy_app_v102/Domain/entities/my_location.dart';
import 'package:routy_app_v102/Presentation/GetX/location_controller.dart';

class DeviceLocation {
 BackgroundLocation location = new BackgroundLocation();
 double distancia;
 double tiempo;
 List<double> veloPromedio;
 List<double> datos;
 double velocidadProm;
 MyLocation _myLocation = MyLocation.getMyLocation();
 LocationController _locationController = Get.find();
 static DeviceLocation _miDeviceLocation;//patron singleton

  static DeviceLocation getDeviceLocation(){
    if (_miDeviceLocation == null){
        _miDeviceLocation = new DeviceLocation._();
    }
    return _miDeviceLocation;
  }
  DeviceLocation._(){//constructor privado
        veloPromedio = [];
        velocidadProm = 0;
        distancia = 0;
        tiempo = 0;
  }


 Future getMyCurrentLocation() async{
  Location value = await location.getCurrentLocation();
  _myLocation.latitud = value.latitude;
  _myLocation.longitud = value.longitude;
  }

  stopUpdates(){
    BackgroundLocation.stopLocationService();
  }

  MyLocation startUpdates(MyLocation location){
    getMyCurrentLocation();
    BackgroundLocation.getPermissions(
      onGranted: () {
        print("Permisos otorgados");
        BackgroundLocation.startLocationService();
        
        BackgroundLocation.getLocationUpdates((value){
            //tiempo = tiempo + 0.5;
            
            _myLocation.tiempo = value.time;
            if(value.speed>0){

              _myLocation.velocidad = value.speed;
              veloPromedio.add(value.speed);//la velocidad promedio solo se actualiza si la velocidad actual es mayor a 1m/s
              _myLocation.velocidadPromedio = veloPromedio.reduce((value, element) => value+element)/veloPromedio.length;
              _myLocation.distancia = _myLocation.distancia + value.speed;
              _myLocation.latitud = value.latitude;
              _myLocation.longitud = value.longitude;

            }   
            _locationController.currentLocationStream.add(_myLocation);
        });

      },
    );
    return _myLocation;
  }
}
