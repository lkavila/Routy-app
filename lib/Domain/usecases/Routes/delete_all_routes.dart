import 'package:routy_app_v102/Data/repositories/route_repository_impl.dart';
import 'package:routy_app_v102/Domain/repositories/route_repository.dart';

mixin DeleteAllRoutesUseCase{
  void call(String uid);
}

class DeleteAllRoutes implements DeleteAllRoutesUseCase{
  @override
  void call(String uid) async{
    final RouteRepository _carRepository = RouteRepositoryImpl();
    _carRepository.deleteAllRoutes(uid);
  }
}