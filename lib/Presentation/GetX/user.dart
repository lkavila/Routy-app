import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:routy_app_v102/Presentation/GetX/route.dart';
import 'package:routy_app_v102/models/user.dart';

class UserX extends GetxController {
  GoogleSignIn googleSignIn;
  FacebookLogin facebookSignIn;
  MyUser myUser;
  String signinWith;

  set setGoogleSignIn(googleSignIn) => this.googleSignIn = googleSignIn;
  set setFacebookSignIn(facebookSignIn) => this.facebookSignIn = facebookSignIn;
  set setSigninWith(String signinWith) => this.signinWith = signinWith;

  Future getUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print("ESto es getuserXXX");
      try {
        DocumentSnapshot dc = await FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid) 
            .get();
      
        this.myUser = new MyUser.fromData(dc.data());
        print("antes de routex");
        final routeX = Get.put(RouteX());
        print("here");
        routeX.getRutas();
        update();
      } catch (e) { 
        salir();
        print("entro al catch");
        print(e.toString());
      }
    }
  }

  Future logOut() async {

    try {
      await googleSignIn.disconnect();
      await facebookSignIn.logOut();
    } catch (e) {
      print(e);
    }
    this.myUser = null;
    await FirebaseAuth.instance.signOut();
  }

  Future salir() async {
    myUser = null;
    await FirebaseAuth.instance.signOut();
    
  }
}
