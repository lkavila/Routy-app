
import 'package:cloud_firestore/cloud_firestore.dart';

class RouteDTO {
  String id;
  String origen;
  String destino;
  double distancia;
  String departamentos;
  double duracion;
  bool circular;
  String userId;
  bool frecuente;
  String tipoCar;
  Timestamp createdAt;

  RouteDTO({String id, String origen, String destino, double distancia,String departamentos, double duracion, bool circular, String userId, bool frecuente, String tipoCar, Timestamp createdAt}){
    this.id = id;
    this.userId = userId;
    this.origen = origen;
    this.destino = destino;
    this.departamentos = departamentos;
    this.circular = circular;
    this.tipoCar = tipoCar;
    this.distancia = distancia;
    this.duracion = duracion;
    this.frecuente = frecuente;
    this.createdAt = createdAt;
    }
  



}