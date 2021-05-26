import 'dart:async';

import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:routy_app_v102/Domain/entities/my_location.dart';

import '../entities/user.dart';

abstract class UserRepository {

  Future<void> logOut(String signinWith, GoogleSignIn googleSignIn, FacebookLogin facebookSignIn);

  Future<void> createAccount(String email, String password, String name);

  Future<void> loginWithFacebook(FacebookLogin facebookLogin);
  
  Future<void> loginWithEmail(String email, String password);

  Future<void> loginWithGoogle(GoogleSignIn googleSignIn);
  
  Future<UserEntity> getCurrentUser();

  MyLocation getCurrentLocation(MyLocation location);

  stopLocationStream();

  sendNotificationFinishRoute();

  Future getCurrentLatLong();

}