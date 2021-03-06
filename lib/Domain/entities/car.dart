import 'package:cloud_firestore/cloud_firestore.dart';

class CarEntity {
  final String id;
  String name;
  String tipoCar;
  String tipoCarApi;
  String tipoCombustible;
  double recorrido;
  double consumo;
  double consumido;
  double uso;
  Timestamp createdAt;

  CarEntity(
      {this.id,
      this.name,
      this.tipoCar,
      this.tipoCarApi,
      this.recorrido,
      this.uso,
      this.consumo,
      this.consumido,
      this.createdAt,
      this.tipoCombustible});

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
      'tipoCombustible': tipoCombustible,
    };
  }
}
