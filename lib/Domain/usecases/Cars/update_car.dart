import 'package:routy_app_v102/Data/repositories/car_repository_impl.dart';
import 'package:routy_app_v102/Domain/entities/car.dart';
import 'package:routy_app_v102/Domain/entities/user.dart';
import 'package:routy_app_v102/Domain/repositories/car_repository.dart';

mixin UpdateCarUseCase{
  void call(UserEntity user, String carId, double recorrido, double uso);
}

class UpdateCar implements UpdateCarUseCase{
  @override
 void call(UserEntity user, String carId, double recorrido, double uso){

    CarEntity car = user.vehiculos.where((element) => element.id==carId).first;
    user.vehiculos.remove(car);
    //recorrido esta en metros y para el consumo se debe poner en kilometros
    double consumido = (car.consumo/100)*(recorrido/1000);
    car.consumido = car.consumido + consumido;
    car.uso = car.uso + uso;
    car.recorrido = car.recorrido + recorrido;
    user.vehiculos.add(car);
    print(car.toJson());
    final CarRepository _carRepository = CarRepositoryImpl();
     _carRepository.updateCar(user.id, carId, car.recorrido, car.consumido, car.uso);
  }
}