
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:routy_app_v102/Domain/entities/route.dart';

class RouteModel extends RouteEntity{

  RouteModel({
  String origen,
  String destino,
  List<LatLng> markerPoints,
  List<LatLng> polyPoints,
  double distancia,
  String departamentos,
  double duracion,
  bool circular,
  String userId,
  Timestamp createdAt,
  String tipoCar,
  bool frecuente,
  }): super (userId:userId, origen:origen, destino:destino, departamentos:departamentos, circular:circular, tipoCar:tipoCar, distancia:distancia, duracion:duracion, markerPoints:markerPoints, polyPoints:polyPoints, createdAt:createdAt);


  factory  RouteModel.fromData(Map<String,dynamic> data){
      return RouteModel(
        userId : data['userId'],
        createdAt : data['createdAt'],
        origen : data['origen'],
        destino : data['destino'],
        departamentos : data['departamentos'],
        circular : data['circular'],
        tipoCar : data['tipoCar'],
        distancia : data['distancia'],
        frecuente : data['frecuente'],
        duracion : data['duracion'],
        polyPoints : (List<GeoPoint>.from(data['polyPoints'])).map((e) => new LatLng(e.latitude, e.longitude)).toList(),
        markerPoints : (List<GeoPoint>.from(data['markerPoints'])).map((e) => new LatLng(e.latitude, e.longitude)).toList(),
      );
  }
  Map<String, dynamic> toJson() {
    List geopoints = [];
    markerPoints.forEach((element) { 
      geopoints.add(GeoPoint(element.latitude, element.longitude));
    });

    List geoPolypoints = [];
    polyPoints.forEach((element) { 
      geoPolypoints.add(GeoPoint(element.latitude, element.longitude));
    });
    
    return {
      
      'userId': userId,
      'tipoCar': tipoCar,
      'createdAt': createdAt,
      'origen': origen,
      'destino': destino,
      'departamentos': departamentos,
      'circular': circular,
      'distancia': distancia,
      'duracion':duracion,
      'frecuente':frecuente,
      'markerPoints':geopoints,
      'polyPoints':geoPolypoints,

    };
  }
}