import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:routy_app_v102/Data/repositories/user_repository_impl.dart';
import 'package:routy_app_v102/Domain/repositories/user_repository.dart';

mixin LogOutUseCase{
  Future<void> call(String signinWith, GoogleSignIn googleSignIn, FacebookLogin facebookSignIn);
}

class LogOut implements LogOutUseCase{
  final UserRepository _routeRepository =  UserRepositoryImpl();
  @override
  Future<void> call(String signinWith, GoogleSignIn googleSignIn, FacebookLogin facebookSignIn) async{
    await _routeRepository.logOut(signinWith, googleSignIn, facebookSignIn);
  }
}