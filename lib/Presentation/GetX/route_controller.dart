import 'package:get/get.dart';
import 'package:routy_app_v102/Domain/entities/route.dart';
import 'package:routy_app_v102/Domain/entities/routeDTO.dart';
import 'package:routy_app_v102/Domain/usecases/Routes/create_route.dart';
import 'package:routy_app_v102/Domain/usecases/Routes/delete_all_routes.dart';
import 'package:routy_app_v102/Domain/usecases/Routes/delete_route.dart';
import 'package:routy_app_v102/Domain/usecases/Routes/get_user_routes.dart';

class RouteController extends GetxController{
  List<RouteEntity> misRutas = [];
  List<RouteDTO> misRutasDto = [];
  var cargandoRutas = false.obs;

 setMisRutas(List<RouteEntity> misRutas) { 
   this.misRutas = misRutas;
   _setMisRutasDto(misRutas);
 }
  
  _setMisRutasDto(List<RouteEntity> misRutas){
    misRutas.forEach((e) {
      misRutasDto.add(new RouteDTO(id: e.id, tipoCar: e.tipoCar, circular: e.circular, frecuente: e.frecuente, departamentos: e.departamentos, origen: e.origen, destino: e.destino, distancia: e.distancia, duracion: e.duracion, userId: e.userId, createdAt: e.createdAt));
    });
  }

  void getRutas() async{
    final GetUserRoutesUseCase _getUserRoutes = GetUserRoutesUC();
    cargandoRutas.value = true;
    await _getUserRoutes.call().then((value) => setMisRutas(value));
    cargandoRutas.value = false;
    update();
  }

  Future<void> saveRoute(RouteEntity ruta)async{
    final CreateRouteUseCase _createRoute = CreateRoute();
    print("saving route");
    print(ruta.id);
    _createRoute.call(ruta.id, ruta.userId, ruta.origen, ruta.destino, ruta.departamentos, ruta.circular, ruta.tipoCar, ruta.distancia, ruta.duracion, ruta.markerPoints, ruta.polyPoints, ruta.createdAt, ruta.frecuente);
    print(ruta.createdAt);
    if(!misRutas.contains(ruta)){
      misRutas.add(ruta); //Error type 'RouteEntity' is not a subtype of type 'RouteModel' of 'value'
      misRutasDto.add(new RouteDTO(id: ruta.id, tipoCar: ruta.tipoCar, circular: ruta.circular, frecuente: ruta.frecuente, departamentos: ruta.departamentos, origen: ruta.origen, destino: ruta.destino, distancia: ruta.distancia, duracion: ruta.duracion, userId: ruta.userId, createdAt: ruta.createdAt));
    //getRutas();
    }
    print("final se saving route");
  }

  void deleteRoute(String id){
    final DeleteRouteUseCase _deleteRoute = DeleteRoute(); 
    _deleteRoute.call(id);
    misRutas.removeWhere((element) => element.id==id);
    misRutasDto.removeWhere((element) => element.id==id);
    update();
  }

  void deleteAllRoutes(String uid){
    final DeleteAllRoutesUseCase _deleteRoute = DeleteAllRoutes(); 
    _deleteRoute.call(uid);
    misRutas.clear();
    misRutasDto.clear();
    update();
  }
  
  void actualizarRutas(RouteEntity ruta){
    misRutas.add(ruta);
    misRutasDto.add(new RouteDTO(id: ruta.id, tipoCar: ruta.tipoCar, circular: ruta.circular, frecuente: ruta.frecuente, departamentos: ruta.departamentos, origen: ruta.origen, destino: ruta.destino, distancia: ruta.distancia, duracion: ruta.duracion, userId: ruta.userId, createdAt: ruta.createdAt));

  }

  RouteEntity getRouteForMap(String id){
    return misRutas.where((element) => element.id == id).first;
  }

  limpiar(){
    misRutas = [];
    misRutasDto = [];
  }
}