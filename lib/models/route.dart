import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyRoute {
  final String id;
  final String origen;
  final String destino;
  final List<LatLng> markerPoints;
  final List<LatLng> polyPoints;
  final double distancia;
  final String departamentos;
  final double duracion;
  final bool circular;
  final String userId;
  final Timestamp createdAt;
  String tipoCar = "driving-car";
  bool frecuente=false;

  bool get getFrecuente => this.frecuente;

  set setFrecuente(bool frecuente) => this.frecuente = frecuente;

  String get getTipoCar => this.tipoCar;

  set setTipoCar(String tipoCar) => this.tipoCar = tipoCar;

  MyRoute({this.id, this.userId, this.origen, this.destino, this.departamentos, this.circular, this.tipoCar, this.distancia, this.duracion, this.markerPoints, this.polyPoints, this.createdAt});

  MyRoute.fromData(Map<String,dynamic> data)
      : id = data['id'],
        userId = data['userId'],
        createdAt = data['createdAt'],
        origen = data['origen'],
        destino = data['destino'],
        departamentos = data['departamentos'],
        circular = data['circular'],
        tipoCar = data['tipoCar'],
        distancia = data['distancia'],
        frecuente = data['frecuente'],
        duracion = data['duracion'],
        polyPoints = (List<GeoPoint>.from(data['polyPoints'])).map((e) => new LatLng(e.latitude, e.longitude)).toList(),
        markerPoints = (List<GeoPoint>.from(data['markerPoints'])).map((e) => new LatLng(e.latitude, e.longitude)).toList();
        
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
      'id': id,
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