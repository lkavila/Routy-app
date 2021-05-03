import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:routy_app_v102/Data/repositories/route_repository_impl.dart';
import 'package:routy_app_v102/Domain/repositories/route_repository.dart';

mixin GetBestWayUseCase{
  Future call(List<LatLng> lugares, String circular);
}

class GetBestWay implements GetBestWayUseCase{
  final RouteRepository _routeRepository =  RouteRepositoryImpl();

  @override
    Future call(List<LatLng> lugares, String circular) async{
      return await _routeRepository.getBestWay(lugares, circular);
    }

}