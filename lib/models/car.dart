
import 'package:cloud_firestore/cloud_firestore.dart';

class Car {
  final String name;
  final String tipoCar;
  String tipoCarApi;
  double recorrido;
  final double consumo;
  double consumido;
  double uso;
  Timestamp createdAt;

  Car({this.name, this.tipoCar, this.tipoCarApi, this.recorrido, this.uso, this.consumo, this.consumido, this.createdAt});

    Car.fromData(Map<String, dynamic> data)
      : name = data['name'],
        tipoCar = data['tipoCar'],
        tipoCarApi = data['tipoCarApi'],
        createdAt = data['createdAt'],
        recorrido = data['recorrido'],
        consumo = data['consumo'],
        consumido = data['consumido'],
        uso = data['uso'];


  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'tipoCar': tipoCar,
      'tipoCarApi': tipoCarApi,
      'createdAt': createdAt,
      'recorrido': recorrido,
      'consumo': consumo,
      'consumido': consumido,
      'uso': uso,
    };
  }

}