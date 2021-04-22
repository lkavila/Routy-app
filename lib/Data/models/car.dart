import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:routy_app_v102/Domain/entities/car.dart';

class CarModel extends CarEntity {
  CarModel({
    final String id,
    String name,
    String tipoCar,
    String tipoCarApi,
    double recorrido,
    double consumo,
    double consumido,
    double uso,
    String tipoCombustible,
    Timestamp createdAt,
  }) : super(
            id: id,
            name: name,
            tipoCar: tipoCar,
            tipoCarApi: tipoCarApi,
            recorrido: recorrido,
            uso: uso,
            consumo: consumo,
            consumido: consumido,
            createdAt: createdAt,
            tipoCombustible: tipoCombustible);

  factory CarModel.fromData(Map<String, dynamic> data) {
    return CarModel(
        id: data['id'],
        name: data['name'],
        tipoCar: data['tipoCar'],
        tipoCarApi: data['tipoCarApi'],
        createdAt: data['createdAt'],
        recorrido: data['recorrido'],
        consumo: data['consumo'],
        consumido: data['consumido'],
        uso: data['uso'],
        tipoCombustible: data['tipoCombustible']);
  }
}
