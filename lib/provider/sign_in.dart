import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';


class SignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  final facebookSignIn = FacebookLogin();
  bool _isSigningIn;
  String _signinWith;

  SignInProvider() {
    _isSigningIn = false;
    _signinWith = "";
  }

  bool get isSigningIn => _isSigningIn;

  String get signinWith => this._signinWith;

  set signinWith(String value) => this._signinWith = value;

  set isSigningIn(bool isSigningIn) {
    _isSigningIn = isSigningIn;
    notifyListeners();
  }

  Future loginWithGoogle() async {
    isSigningIn = true;

    final user = await googleSignIn.signIn();
    if (user == null) {
      isSigningIn = false;
      return;
    } else {
      final googleAuth = await user.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      _signinWith = "Google";
      isSigningIn = false;
    }
  }

  Future loginWithFacebook() async{
    isSigningIn = true;

    final res = await facebookSignIn.logIn(['email']);

    switch(res.status){
      case FacebookLoginStatus.loggedIn:
      print('It worked');

      //Get Token
      final FacebookAccessToken fbToken = res.accessToken;

      //Convert to Auth Credential
      final AuthCredential credential 
        = FacebookAuthProvider.credential(fbToken.token);

      //User Credential to Sign in with Firebase
      final result = await FirebaseAuth.instance.signInWithCredential(credential);
      _signinWith = "Facebook";
      print('${result.user.displayName} is now logged in');
      break;
      case FacebookLoginStatus.cancelledByUser:
      print('The user canceled the login');
      break;
      case FacebookLoginStatus.error:
      
      print('There was an error');
      break;
    }
    isSigningIn = false;

  }

  void logoutGoogle() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }

    void logoutFacebook() async {
    await facebookSignIn.logOut();
    FirebaseAuth.instance.signOut();
  }
}