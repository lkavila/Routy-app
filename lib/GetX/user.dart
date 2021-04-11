import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:routy_app_v102/GetX/route.dart';
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
    print("ESto es getuserXXX");
    if (user != null) {
      DocumentSnapshot dc = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();
      print(dc.data());
      try {
        this.myUser = new MyUser.fromData(dc.data());
        print(myUser.toJson());
        update();
        final routeX = Get.put(RouteX());
        routeX.getRutas();
      } catch (e) {
        FirebaseAuth.instance.signOut();
        print("entro al catch");
        print(e.toString());
      }
    }
  }

  void logOut() async {
    if (signinWith == "Google") {
      print("cerrar sesion google");
      await googleSignIn.disconnect();
    } else if (signinWith == "Facebook") {
      print("cerrar sesion facebook");
      await facebookSignIn.logOut();
    }
    FirebaseAuth.instance.signOut();
    this.myUser = null;
  }

  void salir() {
    FirebaseAuth.instance.signOut();
    this.myUser = null;
  }
}
