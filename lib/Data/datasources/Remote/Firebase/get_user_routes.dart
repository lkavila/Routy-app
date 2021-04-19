import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:routy_app_v102/Data/models/route.dart';

class GetUserRoutes{

  Future<List<RouteModel>> getRutas() async{
    //final RouteX routeX = Get.find();
    List<RouteModel> misRutas = [];
    final user = FirebaseAuth.instance.currentUser;
    print("Esto es firebase/get_user_routes");
    final String uid = user.uid;
    if(misRutas.isEmpty){
      try {
        QuerySnapshot query = await FirebaseFirestore.instance
            .collection("routes")
            .where('userId', isEqualTo: uid)
            .get();

          query.docs.forEach((element) {
              misRutas.add(RouteModel.fromData(element.data()));
          });
          
        } catch (e) {
          FirebaseAuth.instance.signOut();
          print("entro al catch");
          print(e.toString());
          return null;
        }
    }
    return misRutas;
  }
}