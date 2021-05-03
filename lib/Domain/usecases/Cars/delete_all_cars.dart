import 'package:routy_app_v102/Data/repositories/car_repository_impl.dart';
import 'package:routy_app_v102/Domain/repositories/car_repository.dart';

mixin DeleteAllCarUseCase{
  void call(String id);
}

class DeleteAllCar implements DeleteAllCarUseCase{
  @override
  void call(String id) {
    final CarRepository _carRepository = CarRepositoryImpl();
    _carRepository.deleteAllCars(id);
  }
}