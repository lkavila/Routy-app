import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:routy_app_v102/GetX/user.dart';
import 'package:routy_app_v102/models/car.dart';
import 'package:routy_app_v102/models/user.dart';

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

      UserCredential currentUser =
          await FirebaseAuth.instance.signInWithCredential(credential);

      addAccount(currentUser.user, currentUser.user.displayName,
          currentUser.user.email, Timestamp.now(), currentUser.user.photoURL);
      obtenerUserX();
      _signinWith = "Google";
      isSigningIn = false;
    }
  }
  obtenerUserX(){
    final UserX userx = Get.find();
  }
  Future loginWithFacebook() async {
    isSigningIn = true;

    final res = await facebookSignIn.logIn(['email']);

    switch (res.status) {
      case FacebookLoginStatus.loggedIn:
        print('It worked');

        //Get Token
        final FacebookAccessToken fbToken = res.accessToken;

        //Convert to Auth Credential
        final AuthCredential credential =
            FacebookAuthProvider.credential(fbToken.token);

        //User Credential to Sign in with Firebase
        final currentUser =
            await FirebaseAuth.instance.signInWithCredential(credential);

        addAccount(currentUser.user, currentUser.user.displayName,
            currentUser.user.email, Timestamp.now(), currentUser.user.photoURL);
        obtenerUserX();
        _signinWith = "Facebook";
        print('${currentUser.user.displayName} is now logged in');
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

  Future createAccount(String email, String password, String imageUrl,
      Timestamp createdAt, String name) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      User user = FirebaseAuth.instance.currentUser;

      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }

      addAccount(user, name, email, createdAt, imageUrl);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('La contraseña es muy debil.');
      } else if (e.code == 'email-already-in-use') {
        print('Este Correo electronico ya existe.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future loginWithEmail(String email, String password) async {
    isSigningIn = true;
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      /*if (!user.emailVerified) {
        await user.sendEmailVerification();
      }*/
      obtenerUserX();
      _signinWith = "Email";
    } on PlatformException catch (e) {
      switch (e.code) {
        case "wrong-password":
          print('La contraseña es incorrecta.');
          break;
        case "weak-password":
          print('La contraseña es muy debil.');
          break;
        case "invalid-email":
          print("Correo invalido");
          break;
        default:
          print("An undefined Error happened.");
      }
    } catch (e) {
      print(e);
    }
    isSigningIn = false;
  }

  void addAccount(User user, name, email, createdAt, imageUrl) async {
    print("Esto es addaccount");
    //creo mi propio usuario y lo guardo en la base de datos cloud firestore
    DocumentReference document =
        FirebaseFirestore.instance.collection("users").doc(user.uid);
    //si el documento no esta vacio significa que ya se registro este usuario, si esta vacio, hay que agregarlo
    if (await document.get().then((value) => value.data() == null)) {
      //creo mi propio usuario y lo guardo en la base de datos cloud firestore
      List<Car> vehiculos = [];
      print("antes de crear user");
      MyUser myuser =
          new MyUser(user.uid, name, email, createdAt, imageUrl, vehiculos);
      print("llego aquí");
      document.set(myuser.toJson());
      print(myuser.toJson());
    }
  }

  void logOut() async {
    if (signinWith == "Google") {
      await googleSignIn.disconnect();
    } else if (signinWith == "Facebook") {
      await facebookSignIn.logOut();
    }
    FirebaseAuth.instance.signOut();
  }
}
