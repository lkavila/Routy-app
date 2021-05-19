import 'package:routy_app_v102/Data/repositories/user_repository_impl.dart';
import 'package:routy_app_v102/Domain/repositories/user_repository.dart';

mixin StopLocationUseCase{
  call();
}

class StopLocation implements StopLocationUseCase{
  final UserRepository _routeRepository =  UserRepositoryImpl();
  @override
  call() {
    return  _routeRepository.stopLocationStream();
  }
}