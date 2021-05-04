import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteAllRoutesFirebase{

  deleteAllRoutes(String uid){
    //ids.forEach((id) {
    //  rutas.doc(id).delete().then((value) => print("route deleted"))
    //  .catchError((error) => print("Failed to delete user's vehicles: $error"));
    //});

    var rutas = FirebaseFirestore.instance.collection('routes').where('userId', isEqualTo: uid);
    rutas.get().then((querySnapshot) {
      querySnapshot.docs.forEach((element) {
        element.reference.delete();
      });
    });
    
  }
}