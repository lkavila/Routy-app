import 'package:routy_app_v102/Data/datasources/Remote/Firebase/Cars/crear_car.dart';
import 'package:routy_app_v102/Data/datasources/Remote/Firebase/Cars/delete_all_cars.dart';
import 'package:routy_app_v102/Data/datasources/Remote/Firebase/Cars/delete_car.dart';
import 'package:routy_app_v102/Data/datasources/Remote/Firebase/Cars/edit_car.dart';
import 'package:routy_app_v102/Data/datasources/Remote/Firebase/Cars/update_car.dart';
import 'package:routy_app_v102/Domain/repositories/car_repository.dart';

class CarRepositoryImpl implements CarRepository{

  @override
  Future<void> createCar(String name, String tipo, double consumo, String combustible) async{
    final CreateCarFirebase _createCar = CreateCarFirebase();
    await _createCar.crearVehiculo(name, tipo, consumo, combustible);
  }

  @override
  void updateCar(String userId, String carId, double recorrido, double consumido, double uso){
    final UpdateCarFirebase _updateCar = UpdateCarFirebase();
    _updateCar.updateVehicle(userId, carId, recorrido, consumido, uso);
  }

  @override
  Future<void> editCar(String userId, String carId, String name, String tipoCombustible, double consumo, String tipoCar, String tipoApiCar)async{
    final EditCarFirebase _editCar = EditCarFirebase();
    await _editCar.editCar(userId, carId, name, tipoCombustible, consumo, tipoCar, tipoApiCar);
  }

  @override
  void deleteCar(String id){
    final DelteCarFirebase _deleteCar = DelteCarFirebase();
    _deleteCar.deleteCar(id);
  }

  @override
  void deleteAllCars(String userId){
    final DelteAllCarsFirebase _deleteCar = DelteAllCarsFirebase();
    _deleteCar.deleteAllCars(userId);
  }
}