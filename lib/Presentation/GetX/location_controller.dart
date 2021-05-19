
import 'dart:async';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:routy_app_v102/Domain/entities/my_location.dart';
import 'package:routy_app_v102/Domain/usecases/Users/get_current_location.dart';

class LocationController extends GetxController{
  
  StreamController<MyLocation> currentLocationStream = StreamController<MyLocation>.broadcast();
  MyLocation location = new MyLocation();
  Location gps = new Location();
  bool _serviceEnabled;

  getLocationStream(){
    final GetCurrentLocationUseCase _getlocation = GetCurrentLocation();
    currentLocationStream.add(_getlocation.call(location));
  }

  Future<void> requestGPS() async{
    _serviceEnabled = await gps.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await gps.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
  }


}