import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/Presentation/GetX/user_controller.dart';

class DelteCarFirebase{

  void deleteCar(String id){
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    final UserController uc = Get.find();
    users.doc(uc.user.id)
      .update({'vehiculos.$id': FieldValue.delete()})
      .then((value) => print("car created Updated"))
      .catchError((error) => print("Failed to update user vehiculo: $error"));
  }
}