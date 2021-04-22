import 'package:routy_app_v102/Data/repositories/car_repository_impl.dart';
import 'package:routy_app_v102/Domain/repositories/car_repository.dart';

mixin EditCarUseCase{
  Future<void> call(String id, String name, String tipoCombustible, double consumo, String tipoCar, String tipoApiCar);
}

class EditCar implements EditCarUseCase{
  @override
  Future<void> call(String id, String name, String tipoCombustible, double consumo, String tipoCar, String tipoApiCar) async{
    final CarRepository _carRepository = CarRepositoryImpl();
    await _carRepository.editCar(id, name, tipoCombustible, consumo, tipoCar, tipoApiCar);
  }
}