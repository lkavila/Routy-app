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
  void saveRoute(RouteEntity ruta){
    final CreateRouteUseCase _createRoute = CreateRoute();
    print("saving route");
    _createRoute.call(ruta.userId, ruta.origen, ruta.destino, ruta.departamentos, ruta.circular, ruta.tipoCar, ruta.distancia, ruta.duracion, ruta.markerPoints, ruta.polyPoints, ruta.createdAt);
    print(ruta.createdAt);
    //misRutas.add(ruta); //Error type 'RouteEntity' is not a subtype of type 'RouteModel' of 'value'
    getRutas();
    print("final se save route");
  }
  
  void actualizarRutas(RouteEntity ruta){
    misRutas.add(ruta);
  }

  limpiar(){
    misRutas = [];
  }
}