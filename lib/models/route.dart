import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Route {
  final String id;
  final String origen;
  final String destino;
  final List<LatLng> puntos;
  final Set<Polyline> polyLines; // For holding instance of Polyline
  final Set<Marker> markers; 
  final double distancia;
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

  Route({this.id, this.userId, this.origen, this.destino, this.circular, this.tipoCar, this.distancia, this.duracion, this.puntos, this.polyLines, this.markers, this.createdAt});

  Route.fromData(Map<String,dynamic> data)
      : id = data['id'],
        userId = data['userId'],
        createdAt = data['createdAt'],
        origen = data['origen'],
        destino = data['destino'],
        circular = data['circular'],
        tipoCar = data['tipoCar'],
        distancia = data['distancia'],
        frecuente = data['frecuente'],
        duracion = data['duracion'],
        puntos = data['puntos'],
        polyLines = data['polyLines'],
        markers = data['markers'];
  
    Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'tipoCar': tipoCar,
      'createdAt': createdAt,
      'origen': origen,
      'destino': destino,
      'circular': circular,
      'distancia': distancia,
      'duracion':duracion,
      'frecuente':frecuente,
      'puntos':puntos,
      'polyLines':polyLines,
      'markers':markers,

    };
  }

}