
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/models/route.dart';

class RouteX extends GetxController{
  List<MyRoute> misRutas = [];

  Future getRutas() async{
    final user = FirebaseAuth.instance.currentUser;
    print("ESto es GetRutasX");
    if (user != null) {
      final String uid = user.uid;
    try {
      QuerySnapshot query = await FirebaseFirestore.instance
          .collection("routes")
          .where('userId', isEqualTo: uid)
          .get();
      
        query.docs.forEach((element) {
            misRutas.add(MyRoute.fromData(element.data()));
            print(element.data());
         });
      } catch (e) {
        FirebaseAuth.instance.signOut();
        print("entro al catch");
        print(e.toString());
      }
    }
    

  }

  limpiar(){
    this.misRutas = [];
  }

}