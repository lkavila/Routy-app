import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  final String id;
  final String fullName;
  final String email;
  final Timestamp createdAt;
  final String image;

  MyUser(this.id, this.fullName, this.email, this.createdAt, this.image);

  MyUser.fromData(Map<String, dynamic> data)
      : id = data['id'],
        fullName = data['fullName'],
        email = data['email'],
        createdAt = data['createdAt'],
        image = data['image'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'createdAt': createdAt,
      'image': image,
    };
  }
}