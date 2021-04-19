import 'package:routy_app_v102/Data/repositories/route_repository_impl.dart';
import 'package:routy_app_v102/Domain/entities/route.dart';
import 'package:routy_app_v102/Domain/repositories/route_repository.dart';

mixin CreateRouteUseCase{
  void call(RouteEntity ruta);
}

class CreateRoute implements CreateRouteUseCase{
  final RouteRepository _routeRepository =  RouteRepositoryImpl();
  @override

  void call(RouteEntity ruta){
    _routeRepository.createRoute(ruta);
  }
}