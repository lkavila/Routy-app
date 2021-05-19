import 'package:routy_app_v102/Data/repositories/user_repository_impl.dart';
import 'package:routy_app_v102/Domain/entities/my_location.dart';
import 'package:routy_app_v102/Domain/repositories/user_repository.dart';

mixin GetCurrentLocationUseCase{
  MyLocation call(MyLocation location);
}

class GetCurrentLocation implements GetCurrentLocationUseCase{
  final UserRepository _routeRepository =  UserRepositoryImpl();
  @override
  MyLocation call(MyLocation location) {
    return  _routeRepository.getCurrentLocation(location);
  }
}