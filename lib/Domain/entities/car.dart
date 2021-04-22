import 'package:cloud_firestore/cloud_firestore.dart';

class CarEntity {
  final String id;
  final String name;
  final String tipoCar;
  String tipoCarApi;
  double recorrido;
  final double consumo;
  double consumido;
  double uso;
  Timestamp createdAt;

  CarEntity({this.id, this.name, this.tipoCar, this.tipoCarApi, this.recorrido, this.uso, this.consumo, this.consumido, this.createdAt});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
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