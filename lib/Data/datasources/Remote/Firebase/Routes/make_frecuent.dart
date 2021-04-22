import 'package:cloud_firestore/cloud_firestore.dart';

class RouteMakeFrecuentFirebase{

  void makeFrecuent(String id, bool frecuente){
    CollectionReference rutas = FirebaseFirestore.instance.collection('routes');
    rutas.doc(id)
      .update({'frecuente': frecuente})
      .then((value) => print("route created Updated"))
      .catchError((error) => print("Failed to update route: $error"));
  }
}