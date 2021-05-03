import 'package:location/location.dart';

class DeviceLocation {
  Location location = new Location();

  LocationData _currentLocation;

  LocationData get currentLocation => this._currentLocation;

    DeviceLocation(){
      location.serviceEnabled().then((value) { 
      if (!value) {
        location.requestService();
      }
      });

    location.hasPermission().then((value){ 
    if (value == PermissionStatus.denied) {
      location.requestPermission().then((value) { 
        if (value == PermissionStatus.granted){
            location.getLocation().then((value){
              location.onLocationChanged.listen((LocationData currentLocation) {
              _currentLocation = currentLocation;
              print(_currentLocation.latitude);
              });
          });
          }
      
        });
        }
      });


    }
}
