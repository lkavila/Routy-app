import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteRouteFirebase{

  deleteRoute(String id){
    CollectionReference rutas = FirebaseFirestore.instance.collection('routes');
    rutas.doc(id).delete()
    .then((value) => print("route deleted"))
    .catchError((error) => print("Failed to delete user's route: $error"));
  }
}