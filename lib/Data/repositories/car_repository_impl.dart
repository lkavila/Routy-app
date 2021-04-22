import 'package:routy_app_v102/Data/datasources/Remote/Firebase/Cars/crear_car.dart';
import 'package:routy_app_v102/Data/datasources/Remote/Firebase/Cars/update_car.dart';
import 'package:routy_app_v102/Domain/repositories/car_repository.dart';

class CarRepositoryImpl implements CarRepository{

  @override
  Future<void> createCar(String name, String tipo, double consumo) async{
    final CreateCarFirebase _createCar = CreateCarFirebase();
    await _createCar.crearVehiculo(name, tipo, consumo);
  }

  @override
  void updateCar(String id, double recorrido, double consumido, double uso){
    final UpdateCarFirebase _updateCar = UpdateCarFirebase();
    _updateCar.updateVehicle(id, recorrido, consumido, uso);
  }
}