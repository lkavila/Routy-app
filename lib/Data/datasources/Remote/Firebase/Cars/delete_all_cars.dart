import 'package:cloud_firestore/cloud_firestore.dart';

class DelteAllCarsFirebase{

  void deleteAllCars(String userId){
    
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.doc(userId)
      .update({'vehiculos': {}})
      .then((value) => print("cars deleted"))
      .catchError((error) => print("Failed to delete user's vehicles: $error"));
  }
}