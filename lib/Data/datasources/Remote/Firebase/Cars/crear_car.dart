import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/Data/models/car.dart';
import 'package:routy_app_v102/Presentation/GetX/user_controller.dart';
import 'package:uuid/uuid.dart';

class CreateCarFirebase{

  CarModel crearVe(String name, String tipo, double consumo, String combustible){
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
        tipoCarApi = "foot-walking";

        break;
      default:
    }
    return CarModel(id: Uuid().v1(), name: name, tipoCar: tipo, tipoCarApi: tipoCarApi, recorrido: 0, uso: 0, consumo: consumo, consumido: 0, createdAt: Timestamp.now(), tipoCombustible: combustible);

  }

 Future<void> crearVehiculo(String name, String tipo, double consumo, String combustible){
   final UserController uc = Get.find();
    CarModel carro = crearVe( name,  tipo,  consumo, combustible);
    
    if(uc.user.vehiculos==null || uc.user.vehiculos.isEmpty){
      List<CarModel> primerCar= [carro];
    uc.user.vehiculos = primerCar;
    }else{
      uc.user.vehiculos.add(carro);
    }
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    Map<String, dynamic> map1 = {}; 
    uc.user.vehiculos.forEach((element) {
      map1.addIf(true, element.id, element.toJson());
    });
    print(map1);
    return users
      .doc(uc.user.id)
      .update({'vehiculos': map1})
      .then((value) => print("car created"))
      .catchError((error) => print("Failed to create user vehiculo: $error"));
  }
}