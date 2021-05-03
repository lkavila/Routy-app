import 'package:get/get.dart';
import 'package:routy_app_v102/Domain/entities/car.dart';
import 'package:routy_app_v102/Domain/usecases/Cars/create_car.dart';
import 'package:routy_app_v102/Domain/usecases/Cars/delete_all_cars.dart';
import 'package:routy_app_v102/Domain/usecases/Cars/delete_car.dart';
import 'package:routy_app_v102/Domain/usecases/Cars/edit_car.dart';
import 'package:routy_app_v102/Domain/usecases/Cars/update_car.dart';

class CarController extends GetxController{
  CarEntity car;
  String elegido = "";

  actualizar(String elegido){
    this.elegido = elegido;
    update();
  }

  Future<void> createCar(String name, String tipo, double consumo, String combustible)async{
    final CreateCarUseCase _createCar = CreateCar();
    await _createCar.call(name, tipo, consumo, combustible);
  }

  void updateCar(String id, double recorrido, double consumido, double uso){
    final UpdateCarUseCase _updateCar = UpdateCar();
    _updateCar.call(id, recorrido, consumido, uso);
  }

  Future<void> editCar()async{
    final EditCarUseCase _editcar = EditCar();
    _editcar.call(car.id, car.name, car.tipoCombustible, car.consumo, car.tipoCar, car.tipoCarApi);
  }

  deleteCar(String id){
    final DeleteCarUseCase _delete = DeleteCar();
    _delete.call(id);
  }

  deleteAllCars(String userId){
    final DeleteAllCarUseCase _deleteAll = DeleteAllCar();
    _deleteAll.call(userId);
  }
  
}