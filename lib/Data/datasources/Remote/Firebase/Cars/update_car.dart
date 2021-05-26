import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateCarFirebase{

   void updateVehicle(String userId, String carId, double recorrido, double consumido, double uso){

    CollectionReference users = FirebaseFirestore.instance.collection('users');

    
    users.doc(userId)
      .update({'vehiculos.$carId.uso': uso,
              'vehiculos.$carId.consumido': consumido,
              'vehiculos.$carId.recorrido': recorrido})
      .then((value) => print("car created Updated"))
      .catchError((error) => print("Failed to update user vehiculo: $error"));
  }
}