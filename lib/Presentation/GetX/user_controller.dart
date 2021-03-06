import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:routy_app_v102/Domain/entities/user.dart';
import 'package:routy_app_v102/Domain/usecases/Users/create_account.dart';
import 'package:routy_app_v102/Domain/usecases/Users/get_user.dart';
import 'package:routy_app_v102/Domain/usecases/Users/log_out.dart';
import 'package:routy_app_v102/Domain/usecases/Users/login_email_pass.dart';
import 'package:routy_app_v102/Domain/usecases/Users/login_facebook.dart';
import 'package:routy_app_v102/Domain/usecases/Users/login_google.dart';

class UserController extends GetxController {
  final googleSignIn = GoogleSignIn();
  final facebookSignIn = FacebookLogin();
  UserEntity user;
  bool _isSigningIn = false;
  String _signinWith;
  bool get isSigningIn => this._isSigningIn;
  bool noRepeat=true;

 set isSigningIn(bool value) {
    this._isSigningIn = value;
    update();
    }

  get signinWith => this._signinWith;

 set signinWith(value) => this._signinWith = value;

  UserController() {
    _isSigningIn = false;
    _signinWith = "";
  }

  Future getUser() async {
    final GetCurrentUserUseCase _getUser = GetCurrentUser();
    await _getUser.call().then((value) => this.user=value);
    update();
  }
  
  Future loginWithGoogle() async {
    isSigningIn = true;
    update();
    final LoginWithGoogleUseCase _loginGoogle = LoginWithGoogle();
    await _loginGoogle.call(googleSignIn);
    _signinWith = "Google";
    isSigningIn = false;
    update();
    
  }
  Future loginWithFacebook() async {
    isSigningIn = true;
    update();
    final LoginWithFacebookUseCase _loginFacebook = LoginWithFacebook();
    await _loginFacebook.call(facebookSignIn);
    _signinWith = "Facebook";
    isSigningIn = false;
    update();
  }

  Future loginWithEmail(String email, String password) async {
    isSigningIn = true;
    update();
    final LoginWithEmailUseCase _loginEmail = LoginWithEmail();
    await _loginEmail.call(email, password);
    isSigningIn = false;
    update();
  }

  Future createAccount(String email, String password, String name) async {
    final CreateAccountUseCase _createAccount = CreateAccount();
    _createAccount.call(email, password, name);
  }


  deleteCarFromList(String id){
    user.vehiculos.removeWhere((element) => element.id == id);
    update();
  }

  deleteAllCarsFromList(){
    user.vehiculos = [];
    update();
  }


  Future logOut() async {
    final LogOutUseCase _logOut = LogOut();
    await _logOut.call(signinWith, googleSignIn, facebookSignIn);
    user = null;
  }

  Future salir() async {
    user = null;
    await FirebaseAuth.instance.signOut();
    
  }

}
