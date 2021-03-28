import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/GetX/user.dart';
import 'package:routy_app_v102/models/car.dart';

class Crearvehiculo {

  static Car crearVe(String name, String tipo, double consumo){
    switch (tipo) {
      case "Carro":
        tipo = "driving-car";
        break;
      case "Camión":
        tipo = "driving-hgv";
        break;
      case "Motocicleta":
        tipo = "cycling-electric";
        break;
      case "Bicicleta":
        tipo =  "cycling-regular";
        break;
      case "A pie":
        tipo = "oot-walking";
        break;
      default:
    }

    return Car(name: name, tipoCar: tipo, recorrido: 0, uso: 0, consumo: consumo, consumido: 0, createdAt: Timestamp.now());

  }

 static Future< void>  crear(String name, String tipo, double consumo){
    Car carro = crearVe( name,  tipo,  consumo);
    final UserX userx = Get.find();
    if(userx.myUser.vehiculos==null){
      List<Car> primerCar= [carro];
    userx.myUser.vehiculos = primerCar;
    }else{
      userx.myUser.vehiculos.add(carro);
    }
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return users
      .doc(userx.myUser.id)
      .update({'vehiculos': FieldValue.arrayUnion(userx.myUser.vehiculos)})
      .then((value) => print("User Updated"))
      .catchError((error) => print("Failed to update user vehiculo: $error"));
  }

  static Future<void> editar(){
    return null; //es necesario editar vehiculos¿?
  }
}