import 'package:routy_app_v102/Data/repositories/user_repository_impl.dart';
import 'package:routy_app_v102/Domain/entities/user.dart';
import 'package:routy_app_v102/Domain/repositories/user_repository.dart';

mixin GetCurrentUserUseCase{
  Future<UserEntity> call();
}

class GetCurrentUser implements GetCurrentUserUseCase{
  final UserRepository _routeRepository =  UserRepositoryImpl();
  @override
  Future<UserEntity> call() async{
    return await _routeRepository.getCurrentUser();
  }
}