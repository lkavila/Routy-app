import 'package:location/location.dart';
import 'package:routy_app_v102/Data/repositories/user_repository_impl.dart';
import 'package:routy_app_v102/Domain/repositories/user_repository.dart';

mixin GetCurrentLocationUseCase{
  LocationData call();
}

class GetCurrentLocation implements GetCurrentLocationUseCase{
  final UserRepository _routeRepository =  UserRepositoryImpl();
  @override
  LocationData call() {
    return  _routeRepository.getCurrentLocation();
  }
}