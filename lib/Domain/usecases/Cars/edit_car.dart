import 'package:get/get.dart';
import 'package:routy_app_v102/Data/models/car.dart';
import 'package:routy_app_v102/Data/repositories/car_repository_impl.dart';
import 'package:routy_app_v102/Domain/entities/car.dart';
import 'package:routy_app_v102/Domain/repositories/car_repository.dart';
import 'package:routy_app_v102/Presentation/GetX/user_controller.dart';

mixin EditCarUseCase {
  Future<void> call(String id, String name, String tipoCombustible,
      double consumo, String tipoCar);
}

class EditCar implements EditCarUseCase {
  @override
  Future<void> call(String id, String name, String tipoCombustible,
      double consumo, String tipoCar) async {
    final UserController uc = Get.find();
    String tipoApiCar;
    switch (tipoCar) {
      case "Carro":
        tipoApiCar = "driving-car";
        break;
      case "Camión":
        tipoApiCar = "driving-hgv";
        break;
      case "Motocicleta":
        tipoApiCar = "cycling-electric";
        break;
      case "Bicicleta":
        tipoApiCar = "cycling-regular";
        break;
      case "A pie":
        tipoApiCar = "foot-walking";
        break;
      default:
        tipoApiCar = "driving-car";
        break;
    }
    CarEntity car =
        uc.user.vehiculos.where((element) => element.id == id).first;
    CarModel newCar = new CarModel(
        id: id,
        name: name,
        tipoCar: tipoCar,
        tipoCarApi: tipoApiCar,
        recorrido: car.recorrido,
        uso: car.uso,
        consumo: consumo,
        consumido: car.consumido,
        createdAt: car.createdAt,
        tipoCombustible: tipoCombustible);
    uc.user.vehiculos.remove(car);
    uc.user.vehiculos.add(newCar);
    print(newCar.toJson());
    final CarRepository _carRepository = CarRepositoryImpl();
    await _carRepository.editCar(
        uc.user.id, id, name, tipoCombustible, consumo, tipoCar, tipoApiCar);
  }
}
