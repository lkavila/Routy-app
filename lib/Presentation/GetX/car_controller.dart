import 'package:get/get.dart';
import 'package:routy_app_v102/Domain/usecases/Cars/create_car.dart';

class CarController extends GetxController{

  Future<void> createCar(String name, String tipo, double consumo)async{
    final CreateCarUseCase _createCar = CreateCar();
    await _createCar.call(name, tipo, consumo);
  }
  
}