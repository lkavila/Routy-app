import 'package:routy_app_v102/Data/repositories/user_repository_impl.dart';
import 'package:routy_app_v102/Domain/repositories/user_repository.dart';

mixin GetCurrentLatLongUseCase{
   Future call();
}

class GetCurrentLatLong implements GetCurrentLatLongUseCase{
  final UserRepository _routeRepository =  UserRepositoryImpl();
  @override
   Future call() async{
      await _routeRepository.getCurrentLatLong();
  }
}