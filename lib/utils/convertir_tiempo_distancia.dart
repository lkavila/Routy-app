class ConvertirTD{

  static String convertDistancia(double distancia){
    if (distancia<1000){
      return distancia.round().toString()+" metros";
    }
    distancia = distancia/1000; //distancia se recibe en metros y se pasa a kilometros 
    if(distancia>=100000){
      return distancia.round().toString()+" kilometros";
    }else{
      int kil = distancia.floor();
      double metros = (distancia - kil)*1000;
      return (kil.toString()+" kilometros y "+metros.round().toString()+" mts");
    }
  } 

  static String convertirTiempo(double duracion){
    //duracion esta en segundos
    if(duracion<=60){
      return duracion.toString()+" segundos";
    }else{
      duracion = duracion/60;
      if (duracion<60){
        double min = duracion.ceilToDouble();
        return (min.round().toString()+" minutos");
      }else{
        duracion = duracion/60;
        double hours = duracion.floorToDouble();
        double min = (duracion - hours)*60;
        if (hours==1){
          return (hours.round().toString()+" hora y "+min.round().toString()+" min");
        }else{
          return (hours.round().toString()+" horas y "+min.round().toString()+" min");
        }
      }

    }
  }

  static double asignarFactorVelocidad(String tipoCar) {
    double factorVelocidad;
    switch (tipoCar) {
      case "Carro":
        factorVelocidad = 1;
        break;
      case "Camión":
        factorVelocidad = 1.45;
        break;
      case "Motocicleta":
        factorVelocidad = 0.7;
        break;
      case "Bicicleta":
        factorVelocidad = 1.5;
        break;
      case "A pie":
        factorVelocidad = 10;

        break;
      default:
        factorVelocidad = 1;
        break;
    }
    return factorVelocidad;
  }
}