import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/GetX/user.dart';
import 'package:routy_app_v102/models/car.dart';

class Crearvehiculo {

  static Car crearVe(String name, String tipo, double consumo){
    String tipoCarApi;
    switch (tipo) {
      case "Carro":
        tipoCarApi = "driving-car";
        break;
      case "Camión":
        tipoCarApi = "driving-hgv";
        break;
      case "Motocicleta":
        tipoCarApi = "cycling-electric";
        break;
      case "Bicicleta":
        tipoCarApi =  "cycling-regular";
        break;
      case "A pie":
        tipoCarApi = "oot-walking";

        break;
      default:
    }

    return Car(name: name, tipoCar: tipo, tipoCarApi: tipoCarApi, recorrido: 0, uso: 0, consumo: consumo, consumido: 0, createdAt: Timestamp.now());

  }

 static Future< void>  crear(String name, String tipo, double consumo){
    Car carro = crearVe( name,  tipo,  consumo);
    final UserX userx = Get.find();
    if(userx.myUser.vehiculos==null || userx.myUser.vehiculos.isEmpty){
      List<Car> primerCar= [carro];
    userx.myUser.vehiculos = primerCar;
    }else{
      userx.myUser.vehiculos.add(carro);
    }
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    Map<String, dynamic> map1 = {}; 
    userx.myUser.vehiculos.forEach((element) {
      map1.addIf(true, element.name, element.toJson());
    });
    print(map1);
    return users
      .doc(userx.myUser.id)
      .update({'vehiculos': map1})
      .then((value) => print("User Updated"))
      .catchError((error) => print("Failed to update user vehiculo: $error"));
  }

  static Future<void> editar(){
    return null; //es necesario editar vehiculos¿?
  }
}