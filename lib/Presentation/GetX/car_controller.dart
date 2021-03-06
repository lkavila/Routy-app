import 'package:get/get.dart';
import 'package:routy_app_v102/Domain/entities/car.dart';
import 'package:routy_app_v102/Domain/entities/user.dart';
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

  void updateCar(UserEntity user, double recorrido, double uso){
    final UpdateCarUseCase _updateCar = UpdateCar();
    _updateCar.call(user, this.car.id, recorrido, uso);
  }

  Future<void> editCar(String id, String name, String tipoCombustible, double consumo, String tipoCar)async{
    final EditCarUseCase _editcar = EditCar();
    _editcar.call(id, name, tipoCombustible, consumo, tipoCar);
  }

  deleteCar(String id){
    final DeleteCarUseCase _delete = DeleteCar();
    _delete.call(id);
    update();
  }

  deleteAllCars(String userId){
    final DeleteAllCarUseCase _deleteAll = DeleteAllCar();
    _deleteAll.call(userId);
    update();
  }
  
}