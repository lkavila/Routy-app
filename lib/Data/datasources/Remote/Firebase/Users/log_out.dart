import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LogOutFirebase{

  
  Future<void> logOut(String signinWith, GoogleSignIn googleSignIn, FacebookLogin facebookSignIn) async {
    if (signinWith == "Google") {
      await googleSignIn.disconnect();
    } else if (signinWith == "Facebook") {
      await facebookSignIn.logOut();
    }
    FirebaseAuth.instance.signOut();
  }
}