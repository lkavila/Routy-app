import 'dart:async';

import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:routy_app_v102/Data/datasources/Local/device_location.dart';
import 'package:routy_app_v102/Data/datasources/Remote/Firebase/Users/create_account.dart';
import 'package:routy_app_v102/Data/datasources/Remote/Firebase/Users/get_user.dart';
import 'package:routy_app_v102/Data/datasources/Remote/Firebase/Users/log_out.dart';
import 'package:routy_app_v102/Data/datasources/Remote/Firebase/Users/login_email_password.dart';
import 'package:routy_app_v102/Data/datasources/Remote/Firebase/Users/login_facebook.dart';
import 'package:routy_app_v102/Data/datasources/Remote/Firebase/Users/login_google.dart';
import 'package:routy_app_v102/Data/models/user.dart';
import 'package:routy_app_v102/Domain/entities/my_location.dart';
import 'package:routy_app_v102/Domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository{

  Future<void> loginWithFacebook(FacebookLogin facebookLogin) async{
    final LoginWithFacebookFirebase _logingFacebook = LoginWithFacebookFirebase();
    await _logingFacebook.loginWithFacebook(facebookLogin);
  }

  Future<void> loginWithGoogle(GoogleSignIn googleSignIn) async{
    final LoginWithGoogleFirebase _loginWithGoogleFirebase = LoginWithGoogleFirebase();
    await _loginWithGoogleFirebase.loginWithGoogle(googleSignIn);
  }

  Future<void> loginWithEmail(String email, String password)  async{
    final LoginWithEmailPasswordFirebase _loginEmailPass = LoginWithEmailPasswordFirebase();
    await _loginEmailPass.loginWithEmailPassword(email, password);
  }
  
  Future<UserModel> getCurrentUser() async{
    final GetUserFirebase _getUser = GetUserFirebase();
    return await _getUser.getCurrentUser();
  }

  Future<void> logOut(String signinWith, GoogleSignIn googleSignIn, FacebookLogin facebookSignIn) async{
    final LogOutFirebase _logOut = LogOutFirebase();
    await _logOut.logOut(signinWith, googleSignIn, facebookSignIn);
  }

  Future<void> createAccount(String email, String password, String name) async{
    final CreateAccountFirebase _createAccount = CreateAccountFirebase();
    await _createAccount.createAccount(email, password, name);
  }

  MyLocation getCurrentLocation(MyLocation location){
    final DeviceLocation _deviceLocation = DeviceLocation();
    return _deviceLocation.startUpdates(location);
  }
  
}