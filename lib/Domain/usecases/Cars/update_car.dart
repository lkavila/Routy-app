import 'package:routy_app_v102/Data/repositories/car_repository_impl.dart';
import 'package:routy_app_v102/Domain/repositories/car_repository.dart';

mixin UpdateCarUseCase{
  void call(String id, double recorrido, double consumido, double uso);
}

class UpdateCar implements UpdateCarUseCase{
  @override
 void call(String id, double recorrido, double consumido, double uso){
    final CarRepository _carRepository = CarRepositoryImpl();
     _carRepository.updateCar(id, recorrido, consumido, uso);
  }
}