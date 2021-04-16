import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteEntity {
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

  RouteEntity({this.id, this.userId, this.origen, this.destino, this.departamentos, this.circular, this.tipoCar, this.distancia, this.duracion, this.markerPoints, this.polyPoints, this.createdAt});



}