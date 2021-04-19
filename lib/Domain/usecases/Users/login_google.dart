import 'package:google_sign_in/google_sign_in.dart';
import 'package:routy_app_v102/Data/repositories/user_repository_impl.dart';
import 'package:routy_app_v102/Domain/repositories/user_repository.dart';

mixin LoginWithGoogleUseCase{
  Future<void> call(GoogleSignIn googleSignIn);
}

class LoginWithGoogle implements LoginWithGoogleUseCase{
  final UserRepository _routeRepository =  UserRepositoryImpl();
  @override
  Future<void> call(GoogleSignIn googleSignIn) async{
    await _routeRepository.loginWithGoogle(googleSignIn);
  }
}