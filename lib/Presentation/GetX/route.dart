
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/models/route.dart';

class RouteX extends GetxController{
  List<MyRoute> misRutas = [];

  Future getRutas() async{
    final RouteX routeX = Get.find();
    final user = FirebaseAuth.instance.currentUser;
    print("ESto es GetRutasX");
    final String uid = user.uid;
    if(routeX.misRutas.isEmpty){
      try {
        QuerySnapshot query = await FirebaseFirestore.instance
            .collection("routes")
            .where('userId', isEqualTo: uid)
            .get();

          query.docs.forEach((element) {
              misRutas.add(MyRoute.fromData(element.data()));
          });
          update();
        } catch (e) {
          FirebaseAuth.instance.signOut();
          print("entro al catch");
          print(e.toString());
        }
    }


  }

  limpiar(){
    misRutas = [];
  }

}