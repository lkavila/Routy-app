
import 'dart:async';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:routy_app_v102/Domain/entities/my_location.dart';
import 'package:routy_app_v102/Domain/usecases/Users/get_current_location.dart';
import 'package:routy_app_v102/Domain/usecases/Users/get_stream_location.dart';
import 'package:routy_app_v102/Domain/usecases/Users/send_notification_finish_route.dart';
import 'package:routy_app_v102/Domain/usecases/Users/stop_location_stream.dart';

class LocationController extends GetxController{
  
  StreamController<MyLocation> currentLocationStream = StreamController<MyLocation>.broadcast();
  
  MyLocation location = MyLocation.getMyLocation();
  Location gps = new Location();
  bool _serviceEnabled;

  getLocationStream(){
    final GetCurrentLocationUseCase _getlocation = GetCurrentLocation();
    _getlocation.call(location);
  }

  Future getCurrentLatLong()async{
    final GetCurrentLatLongUseCase _getLatLong = GetCurrentLatLong();
    await _getLatLong.call();
  }

  sendNotificationFinishRoute(){
    final SendNotificationFinishUseCase _sendNotification = SendNotificationFinish();
    _sendNotification.call();
  }

  Future<void> requestGPS() async{
    print("Request gps");
    _serviceEnabled = await gps.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await gps.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
  }

  stopLocationStream(){
    final StopLocationUseCase _stop = StopLocation();
    _stop.call();
  }


}