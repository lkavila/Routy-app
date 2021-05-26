import 'dart:async';
import 'package:background_location/background_location.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/Domain/entities/my_location.dart';
import 'package:routy_app_v102/Presentation/GetX/location_controller.dart';

class DeviceLocation {
 BackgroundLocation location = new BackgroundLocation();
 List<double> veloPromedio;
 List<double> datos;
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
  }


 Future getMyCurrentLocation() async{
  Location value = await location.getCurrentLocation();
  _myLocation.latitud = value.latitude;
  _myLocation.longitud = value.longitude;
  }

  stopUpdates(){
    BackgroundLocation.stopLocationService();
    _myLocation.velocidad = 0;
    _myLocation.tiempo = 0;
    _myLocation.distancia = 0;
  }

  sendNotificationRouteFinish(){
    BackgroundLocation.setAndroidNotification(
	      title: "Ha finalizado la ruta",
        message: "Ha culminado la ruta exitosamente, gracias por confiar en nosotros",
        icon: "@mipmap/ic_launcher",
);
  }

  MyLocation startUpdates(MyLocation location){
    getMyCurrentLocation();
    BackgroundLocation.getPermissions(
      onGranted: () {
        print("Permisos otorgados");
        BackgroundLocation.startLocationService();
        BackgroundLocation.getLocationUpdates((value){
            _myLocation.tiempo = _myLocation.tiempo + 0.5;
            if(value.speed>0){
              _myLocation.velocidad = value.speed;
              veloPromedio.add(value.speed);//la velocidad promedio solo se actualiza si la velocidad actual es mayor a 1m/s
              _myLocation.velocidadPromedio = veloPromedio.reduce((value, element) => value+element)/veloPromedio.length;
              _myLocation.distancia = _myLocation.distancia + (value.speed/2);
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
