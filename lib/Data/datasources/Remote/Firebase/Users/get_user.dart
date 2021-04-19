import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/Data/models/user.dart';
import 'package:routy_app_v102/Presentation/GetX/map_route_controller.dart';

class GetUserFirebase{

  Future<UserModel> getCurrentUser() async{
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print("ESto es getuserXXX");
      try {
        DocumentSnapshot dc = await FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid) 
            .get();
      
        UserModel myuser = new UserModel.fromData(dc.data());
        print("antes de routex");
        final routeX = Get.put(RouteController());
        print("here");
        routeX.getRutas();
        return myuser;
      } catch (e) { 
        print("entro al catch");
        print(e.toString());
      }
    }
     return null;
  }
}