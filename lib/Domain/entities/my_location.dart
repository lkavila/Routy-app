
class MyLocation{

  double tiempo;
  double distancia;
  double velocidad;
  double velocidadPromedio;
  double latitud;
  double longitud;

  get getLatitud => this.latitud;

 set setLatitud( latitud) => this.latitud = latitud;

  get getLongitud => this.longitud;

 set setLongitud( longitud) => this.longitud = longitud;

  get getTiempo => this.tiempo;

 set setTiempo( tiempo) => this.tiempo = tiempo;

  get getDistancia => this.distancia;

 set setDistancia( distancia) => this.distancia = distancia;

  get getVelocidad => this.velocidad;

 set setVelocidad( velocidad) => this.velocidad = velocidad;

  get getVelocidadPromedio => this.velocidadPromedio;

 set setVelocidadPromedio( velocidadPromedio) => this.velocidadPromedio = velocidadPromedio;

  MyLocation({tiempo, distancia, velocidad, velocidadPromedio, latitud, longitud});



}