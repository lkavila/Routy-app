import 'package:routy_app_v102/Data/repositories/car_repository_impl.dart';
import 'package:routy_app_v102/Domain/repositories/car_repository.dart';

mixin DeleteCarUseCase{
  void call(String id);
}

class DeleteCar implements DeleteCarUseCase{
  @override
  void call(String id) {
    final CarRepository _carRepository = CarRepositoryImpl();
    _carRepository.deleteCar(id);
  }
}