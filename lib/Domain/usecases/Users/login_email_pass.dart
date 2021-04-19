import 'package:routy_app_v102/Data/repositories/user_repository_impl.dart';
import 'package:routy_app_v102/Domain/repositories/user_repository.dart';

mixin LoginWithEmailUseCase{
  Future<void> call(String email, String pass);
}

class LoginWithEmail implements LoginWithEmailUseCase{
  final UserRepository _routeRepository =  UserRepositoryImpl();
  @override
  Future<void> call(String email, String pass) async{
    await _routeRepository.loginWithEmail(email, pass);
  }
}