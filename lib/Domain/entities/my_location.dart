
class MyLocation{

  double tiempo;
  double distancia;
  double velocidad;
  double velocidadPromedio;
  double latitud;
  double longitud;
  static MyLocation _miLocalizacion;

  static MyLocation getMyLocation(){
    if(_miLocalizacion==null){
      _miLocalizacion = new MyLocation._();
    }
    return _miLocalizacion;
  }

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

  MyLocation._(){
    this.tiempo = 0;
    this.velocidad = 0;
    this.velocidadPromedio = 0;
    this.distancia = 0;
    this.latitud = 10.980368;
    this.longitud = -74.800688;//coordenadas, El recreo mitad de barranquilla
  }



}