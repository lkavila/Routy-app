import 'package:routy_app_v102/Data/repositories/route_repository_impl.dart';
import 'package:routy_app_v102/Domain/repositories/route_repository.dart';

mixin DeleteRouteUseCase{
  void call(String id);
}

class DeleteRoute implements DeleteRouteUseCase{
  @override
  void call(String id) async{
    final RouteRepository _carRepository = RouteRepositoryImpl();
    _carRepository.deleteRoute(id);
  }
}