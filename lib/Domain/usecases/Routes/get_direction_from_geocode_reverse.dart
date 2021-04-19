import 'package:routy_app_v102/Data/repositories/route_repository_impl.dart';
import 'package:routy_app_v102/Domain/repositories/route_repository.dart';

mixin GetDirectionGeocodeRvUseCase {
  Future<List<String>> call(double lon, double lat);
}

class GetDirectionGeocodeRv implements GetDirectionGeocodeRvUseCase{
  final RouteRepository _routeRepository =  RouteRepositoryImpl();

  @override
  Future<List<String>> call(double lon, double lat) async{
    return await _routeRepository.fetchGeo(lon, lat);
  }
}