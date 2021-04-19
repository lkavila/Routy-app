import 'package:routy_app_v102/Data/repositories/user_repository_impl.dart';
import 'package:routy_app_v102/Domain/repositories/user_repository.dart';

mixin CreateAccountUseCase{
  Future<void> call(String email, String password, String name);
}

class CreateAccount implements CreateAccountUseCase{
  final UserRepository _routeRepository =  UserRepositoryImpl();
  @override
  Future<void> call(String email, String password, String name) async{
    return await _routeRepository.createAccount(email, password, name);
  }
}