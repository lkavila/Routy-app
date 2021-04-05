import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:routy_app_v102/models/car.dart';

class MyUser {
  final String id;
  final String fullName;
  final String email;
  final Timestamp createdAt;
  final String image;
  List<Car> vehiculos = [];

  MyUser(this.id, this.fullName, this.email, this.createdAt, this.image,
      this.vehiculos);

  MyUser.fromData(Map<String, dynamic> data)
      : id = data['id'],
        fullName = data['fullName'],
        email = data['email'],
        createdAt = data['createdAt'],
        image = data['image'],
        vehiculos = (data['vehiculos'] != null && data['vehiculos'] !=[])
            ? new Map<String, dynamic>.from(data['vehiculos'])
                .values
                .map((e) => new Car.fromData(e))
                .toList()
            : null;

  Map<String, dynamic> toJson() {
    var map1 = {}; 
    vehiculos.forEach((element) {
      map1.addAll(element.toJson());
    });
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'createdAt': createdAt,
      'image': image,
      'vehiculos': map1,
    };
  }
}
