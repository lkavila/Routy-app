
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:routy_app_v102/Domain/entities/user.dart';
import 'package:routy_app_v102/models/car.dart';
import 'package:meta/meta.dart';

class UserModel extends UserEntity{

  UserModel({
  @required String id,
  @required String fullName,
  @required String email,
  @required Timestamp createdAt,
  @required String image,
  @required List<Car> vehiculos

  }) : super(id:id, fullName:fullName, email:email, createdAt:createdAt, image:image, vehiculos:vehiculos);

  factory UserModel.fromData(Map<String, dynamic> data){
      return UserModel( id : data['id'],
        fullName : data['fullName'],
        email : data['email'],
        createdAt : data['createdAt'],
        image : data['image'],
        vehiculos : (data['vehiculos'] != null && data['vehiculos'] !=[])
            ? new Map<String, dynamic>.from(data['vehiculos'])
                .values
                .map((e) => new Car.fromData(e))
                .toList()
            : null);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map1 = {}; 
    if (vehiculos!=null){
      vehiculos.forEach((element) {
        map1.addAll(element.toJson());
    });
    }
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