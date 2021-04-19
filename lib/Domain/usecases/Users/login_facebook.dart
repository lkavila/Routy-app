import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:routy_app_v102/Data/repositories/user_repository_impl.dart';
import 'package:routy_app_v102/Domain/repositories/user_repository.dart';

mixin LoginWithFacebookUseCase{
  Future<void> call(FacebookLogin facebookSignIn);
}

class LoginWithFacebook implements LoginWithFacebookUseCase{
  final UserRepository _routeRepository =  UserRepositoryImpl();
  @override
  Future<void> call(FacebookLogin facebookSignIn) async{
    await _routeRepository.loginWithFacebook(facebookSignIn);
  }
}