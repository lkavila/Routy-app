import 'package:routy_app_v102/Data/repositories/car_repository_impl.dart';
import 'package:routy_app_v102/Domain/repositories/car_repository.dart';

mixin CreateCarUseCase{
  Future<void> call(String name, String tipo, double consumo, String combustible);
}

class CreateCar implements CreateCarUseCase{
  @override
  Future<void> call(String name, String tipo, double consumo, String combustible) async{
    final CarRepository _carRepository = CarRepositoryImpl();
    await _carRepository.createCar(name, tipo, consumo, combustible);
  }
}