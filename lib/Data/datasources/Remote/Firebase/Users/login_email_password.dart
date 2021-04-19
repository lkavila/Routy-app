import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class LoginWithEmailPasswordFirebase{

  Future<void> loginWithEmailPassword(String email, String password)async{
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      /*if (!user.emailVerified) {
        await user.sendEmailVerification();
      }*/
      
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
  }
}