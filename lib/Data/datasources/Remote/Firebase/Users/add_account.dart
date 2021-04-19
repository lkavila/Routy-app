import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:routy_app_v102/Data/models/car.dart';
import 'package:routy_app_v102/Data/models/user.dart';

class AddAccountFirebase{
  
  Future<void> addAccount(User user, String name, String email, String imageUrl) async{
    print("Esto es addaccount");
    //creo mi propio usuario y lo guardo en la base de datos cloud firestore
    DocumentReference document =
        FirebaseFirestore.instance.collection("users").doc(user.uid);
    //si el documento no esta vacio significa que ya se registro este usuario, si esta vacio, hay que agregarlo
    if (await document.get().then((value) => value.data() == null)) {
      //creo mi propio usuario y lo guardo en la base de datos cloud firestore
      List<CarModel> vehiculos = [];
      print("antes de crear user");
      UserModel myuser =
          new UserModel(id :user.uid, fullName:name, email:email, createdAt:Timestamp.now(), image:imageUrl, vehiculos:vehiculos);
      print("llego aquí");
      document.set(myuser.toJson());
      print(myuser.toJson());
    }
  }  
}