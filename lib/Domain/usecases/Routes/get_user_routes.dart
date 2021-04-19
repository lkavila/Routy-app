import 'package:routy_app_v102/Data/repositories/route_repository_impl.dart';
import 'package:routy_app_v102/Domain/entities/route.dart';
import 'package:routy_app_v102/Domain/repositories/route_repository.dart';

mixin GetUserRoutesUseCase{
  Future<List<RouteEntity>> call();
}

class GetUserRoutesUC implements GetUserRoutesUseCase{
  final RouteRepository _routeRepository = RouteRepositoryImpl();

  @override
  Future<List<RouteEntity>> call() async{
    return await _routeRepository.getUserRoutes();
  }
}