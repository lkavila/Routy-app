abstract class CarRepository{

  Future<void> createCar(String name, String tipo, double consumo, String combustible);

  void updateCar(String id, double recorrido, double consumido, double uso);

  Future<void> editCar(String userId, String carId, String name, String tipoCombustible, double consumo, String tipoCar, String tipoApiCar);

  void deleteCar(String id);

  void deleteAllCars(String userId);

}