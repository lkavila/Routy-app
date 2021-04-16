import 'package:cloud_firestore/cloud_firestore.dart';

class CarEntity {
  final String name;
  final String tipoCar;
  String tipoCarApi;
  double recorrido;
  final double consumo;
  double consumido;
  double uso;
  Timestamp createdAt;

  CarEntity({this.name, this.tipoCar, this.tipoCarApi, this.recorrido, this.uso, this.consumo, this.consumido, this.createdAt});


}