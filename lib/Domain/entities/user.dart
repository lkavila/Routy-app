import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:routy_app_v102/Domain/entities/car.dart';
import 'package:meta/meta.dart';

class UserEntity{
  final String id;
  final String fullName;
  final String email;
  final Timestamp createdAt;
  final String image;
  List<CarEntity> vehiculos;

  UserEntity({
    @required this.id, 
    @required this.fullName,
    @required this.email,
    @required this.createdAt,
    @required this.image,
    @required this.vehiculos});

  List<Object> get props => [id, fullName, email, createdAt, image, vehiculos];
}
