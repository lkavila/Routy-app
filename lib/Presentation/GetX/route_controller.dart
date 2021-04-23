import 'package:get/get.dart';
import 'package:routy_app_v102/Domain/entities/route.dart';
import 'package:routy_app_v102/Domain/usecases/Routes/create_route.dart';
import 'package:routy_app_v102/Domain/usecases/Routes/get_user_routes.dart';

class RouteController extends GetxController{
  List<RouteEntity> misRutas = [];
  var cargandoRutas = false.obs;


  void getRutas() async{
    final GetUserRoutesUseCase _getUserRoutes = GetUserRoutesUC();
    cargandoRutas.value = true;
    await _getUserRoutes.call().then((value) => misRutas = value);
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
    //getRutas();
    }
    print("final se saving route");
  }
  
  void actualizarRutas(RouteEntity ruta){
    misRutas.add(ruta);
  }

  limpiar(){
    misRutas = [];
  }
}