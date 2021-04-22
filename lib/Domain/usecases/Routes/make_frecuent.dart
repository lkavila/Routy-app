import 'package:routy_app_v102/Data/repositories/route_repository_impl.dart';
import 'package:routy_app_v102/Domain/repositories/route_repository.dart';

mixin MakeFrecuentUseCase{
  void call(String id, bool frecuente);
}

class MakeFrecuent implements MakeFrecuentUseCase{
  final RouteRepository _routeRepository =  RouteRepositoryImpl();

  @override
  void call(String id, bool frecuente) {
       _routeRepository.makeFrecuent(id, frecuente);
    }

}