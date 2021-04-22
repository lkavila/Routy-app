import 'package:get/get.dart';
import 'package:routy_app_v102/Domain/usecases/Cars/create_car.dart';
import 'package:routy_app_v102/Domain/usecases/Cars/update_car.dart';

class CarController extends GetxController{

  Future<void> createCar(String name, String tipo, double consumo)async{
    final CreateCarUseCase _createCar = CreateCar();
    await _createCar.call(name, tipo, consumo);
  }

  void updateCar(String id, double recorrido, double consumido, double uso){
    final UpdateCarUseCase _updateCar = UpdateCar();
    _updateCar.call(id, recorrido, consumido, uso);
  }
  
}