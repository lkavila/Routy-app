abstract class CarRepository{

  Future<void> createCar(String name, String tipo, double consumo);

  void updateCar(String id, double recorrido, double consumido, double uso);

}